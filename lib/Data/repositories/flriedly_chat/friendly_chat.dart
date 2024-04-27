import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crowd_verse/presentation/utils/core/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class FriendlyChatService {

  late  io.Socket socket ; 

   
   Future<List<FriendlyChatModel>?>getAllMessages(String userId)async{
   final url =Uri.parse("${EndPoint.baseUrl}/friend/chat/message?FriendID=$userId&page=1&Limit=100");   
   final accessToken = await SecureStorage().readSecureData('AccessToken'); 
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
        List<FriendlyChatModel> friends = friendsJsonList.map((json) { 
        return FriendlyChatModel.fromJson(json);  
       }).toList();   
       return friends;
      }

        }  

       } catch (e) {
            
      log(e.toString());
       } 
       return null;    
   }



   Future<String>getUserIdByToken()async{
   final url =Uri.parse("${EndPoint.baseUrl}/token");   
   final accessToken = await SecureStorage().readSecureData('AccessToken'); 
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
         await SecureStorage().writeSecureData('UserID', idFromJson);
          return idFromJson; 
        }

     } catch (e) {
            
      log(e.toString());
       } 
       return '';
   }

  /////////////////////////
  






   Future<FriendlyChatModel?>  connectSocket() async {
    FriendlyChatModel? chat;
    await getUserIdByToken();
    final accessToken = await SecureStorage().readSecureData('AccessToken');
    socket = io.io(
      'http://hyperhive.vajid.tech',
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
  
   socket.on('receive friendly chat', (data) {
         chat = FriendlyChatModel.fromJson(data);
       log('Received message🐸🐸:${chat!.message}');
    });
     return chat;
         
  }
   
  
 
  void sendMessage(String id, String message) async {

    String senderId = await SecureStorage().readSecureData('UserID');
    
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
}
