import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crowd_verse/data/models/server/channel_message.dart';
import 'package:crowd_verse/presentation/utils/core/endpoints.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/channel_chat/bloc/channel_chat_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/message_bloc/bloc/friendly_message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io; 
  

   late  io.Socket socket ;

 class FriendlyChatService {


  SecureStorage  storage = SecureStorage();
 

   
   Future<List<FriendlyChatModel>?>getAllMessages(String userId)async{
   final url =Uri.parse("${EndPoint.baseUrl}/friend/chat/message?FriendID=$userId&page=1&Limit=100");   
   final accessToken = await storage.readSecureData('AccessToken'); 
       try {
          
        final response = await http.get(
          url, 
          headers: { 
          "AccessToken":accessToken,   
         }, 
        );

        log("response from friendly chat ${response.body}");

        if (response.statusCode==200) {
            final jsonData = jsonDecode(response.body);
        List<dynamic>? friendsJsonList = jsonData['result']['FriendChat']; 
 
          if (friendsJsonList!=null) {
        List<FriendlyChatModel> allMessages = friendsJsonList.map((json) { 
        return FriendlyChatModel.fromJson(json);  
       }).toList();   
       return allMessages.reversed.toList();
      }

        }  

       } catch (e) {
            
      log(e.toString());
       } 
       return null;    
   }

 

   Future<String>getUserIdByToken()async{
   final url =Uri.parse("${EndPoint.baseUrl}/token");   
   final accessToken = await storage.readSecureData('AccessToken'); 
       try {
          
        final response = await http.get(
          url, 
          headers: { 
          "AccessToken":accessToken,   
         }, 
        );

        log("response from token by id: ${response.body}");

        if (response.statusCode==200) {
            final jsonData = jsonDecode(response.body);
          String idFromJson = jsonData['result']['UserID'];
         await storage.writeSecureData('UserID', idFromJson);
          return idFromJson; 
        }

     } catch (e) {
            
      log(e.toString());
       } 
       return '';
   }
 
  /////////////////////////
   


   Future<void> connectSocket({BuildContext? context}) async {  
    await getUserIdByToken();
    final accessToken = await storage.readSecureData('AccessToken');
    socket = io.io(
      EndPoint.baseUrl,
      io.OptionBuilder()
          .setPath('/server')
          .setTransports(['websocket'])
          .setExtraHeaders({'AccessToken': accessToken})
          .disableAutoConnect()   
          .build(), 
    );
    socket.connect();

    socket.onConnect((data) => debugPrint('Socket connected'));
    socket.onConnectError((data) => debugPrint('Connect error: $data'));
    socket.onDisconnect((data) => debugPrint('Socket disconnected'));
    FriendlyChatModel? chat;
    

    socket.on('receive friendly chat', (data) {
      chat = FriendlyChatModel.fromJson(data);
        if (chat!=null) {
           log('Received message🐸🐸:${chat!.message}'); 
           context!.read<FriendlyMessageBloc>().add(ResiveMsgEvent(chat: chat!));
        }
        
     });
      socket.on('broadcast server chat', (data) { 

       ChannelChatModel chanelChat  = ChannelChatModel.fromJson(data);
         
        log('server chat🍎🍎🍎🍎:$data');  

        context!.read<ChannelChatBloc>().add(ReciveChannelMessageEvent(chat: chanelChat));
  
     });
     
   
  } 


   sendMessage(String id, String message,BuildContext context) async {

    String senderId = await storage.readSecureData('UserID');
     
     final json = {
        "sender_id": senderId,
        "recipient_id": id,  
        "Content": message, 
        "Type": "text",
        "Tag":"nil"
      };
     socket.emit(
     'friendly chat',
      jsonEncode(json)
     );
     
  }


 Future< void> sendMessageInChannel({required String channelID,required String serverID,required String message})async{
     String userId = await storage.readSecureData('UserID');
     log("channel id --->$channelID");
     log("server id --->$serverID");
     log(" message --->$message");

    final json = {
     "UserID": int.parse(userId),
     "ChannelID": int.parse(channelID),
     "ServerID": int.parse(serverID),
     "content": message,
     "type": "text"
    };

    socket.emit(
      'server chat',
      jsonEncode(json)
      );

  }
 
}

