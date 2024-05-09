
import 'dart:convert';
import 'dart:developer';

import 'package:crowd_verse/data/models/server/all_channels.dart';
import 'package:crowd_verse/data/models/server/all_server_model.dart';
import 'package:crowd_verse/data/models/server/search_server.dart';
import 'package:crowd_verse/data/models/server/server_details.dart';
import 'package:crowd_verse/data/models/server/server_members.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:crowd_verse/presentation/utils/core/endpoints.dart';
import 'package:http/http.dart' as http;

class ServerService{

    SecureStorage storage = SecureStorage();

 Future<List<ServerModel>?> getAllService()async{
    final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.gellAllServer}");
    final accessToken = await storage.readSecureData('AccessToken'); 

    try {
       final response = await http.get(
      url, 
      headers: {
        "AccessToken":accessToken,
      }
      );
      log("🐷🐷🐷${response.body}");
      
      if (response.statusCode==200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> jsonLst = jsonResponse['result']['UserServerList'];
        List<ServerModel> servers = jsonLst.map((json) {
          return ServerModel.fromJson(json);
        }).toList();     
        return servers;
      } 
      
    } catch (e) {
        log(e.toString());
    }
    return null; 
  }
     

    Future<ServerDetailsModel?> getServerDetails(String serverId)async{
     final url = Uri.parse("${EndPoint.baseUrl}/server/$serverId");
     final accessToken = await storage.readSecureData('AccessToken'); 


     try {
       final response = await http.get(
        url,
        headers: {
          "AccessToken":accessToken,
        }
        );
        log("🐼🐼🐼${response.body}");
        if (response.statusCode==200) {
          final decodedJson = jsonDecode(response.body);
          ServerDetailsModel server = ServerDetailsModel.fromJson(decodedJson['result']);
          return server;
        }
 
     } catch (e) {
       log(e.toString());
     }
       return null;
     }

     Future<void> getAllServers()async{
      final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.getAllServers}");
      final accessToken = await storage.readSecureData('AccessToken'); 
         try {
       final response = await http.get(
        url,
        headers: {
          "AccessToken":accessToken,
        }
        );
        log("🐼🐼🐼${response.body}");
        if (response.statusCode==200) {          
          
        }
 
     } catch (e) {
       log(e.toString());
     }
       
     }

     Future<bool>createServer(String serverName)async{
       final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.createServer}");
       final accessToken = await storage.readSecureData('AccessToken');
        final body={
           "Name":serverName
        };
       try {

        final response = await http.post(
          url,
          headers: {
           "Content-Type":"application/json",
            "AccessToken":accessToken,
          },body: jsonEncode(body)
          );

        log(response.body);

        if (response.statusCode==200) {
          return true;
        }
          
       } catch (e) {
          log(e.toString()); 
       }
        return false;
     }


     Future<bool> uploadServerImage(String imgPath,String serverId)async{
     
         final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadServerImage}") ; 
           final accessToken = await storage.readSecureData('AccessToken'); 

      final header={
          "Content-Type":"multipart/form-data", 
          "AccessToken":accessToken,
        };

      try {
        var request = http.MultipartRequest('PATCH', url);
          request.headers.addAll(header);
          request.fields['Type'] = 'icon';
          request.fields['ServerID'] = serverId;
          request.files.add( 
            await http.MultipartFile.fromPath( 
            'Image',
            imgPath 
          ), 
          );
          final response = await request.send(); 

  
         log("Server image🐔🐔🐔${response.statusCode}");  
         if (response.statusCode==200) {
           return true;
         }
          
      } catch (e) {
        log(e.toString()); 
      }
      return false;
     }



     Future<List<ServerMembersModel>?>getAllServerMembers(String serverId)async{
       final url = Uri.parse("${EndPoint.baseUrl}/server/members?ServerID=$serverId&page=1&Limit=16");
     final accessToken = await storage.readSecureData('AccessToken'); 


     try {
       final response = await http.get(
        url,
        headers: {
          "AccessToken":accessToken, 
        }
        );
        log("server members:${response.body}"); 
        if (response.statusCode==200) {
          final decodedJson = jsonDecode(response.body);
          List<dynamic> jsonLst = decodedJson['result']['List'];
          List<ServerMembersModel>? members =jsonLst.map((json) {
            return ServerMembersModel.fromJson(json);
          }).toList();
           return members;
        }
 
     } catch (e) {
       log(e.toString());
     }
       return null;
     }


       Future<bool>leaveFromServer(String serverId)async{
        final url = Uri.parse("${EndPoint.baseUrl}/server/left");
        final accessToken = await storage.readSecureData('AccessToken'); 
         final body = {
          "ServerID":serverId
         };
       final response = await http.delete(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type":"application/json",
          "AccessToken":accessToken,
        }
        );
        log("🦐🦐🦐${response.body}");
        return response.statusCode==200;
       }
     


        Future<bool>deleteServer(String serverId)async{
        final url = Uri.parse("${EndPoint.baseUrl}/server/destroy");
        final accessToken = await storage.readSecureData('AccessToken'); 
         final body = {
          "ServerID":serverId
         };
       final response = await http.delete(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type":"application/json",
          "AccessToken":accessToken,
        }
        );
        log("🐡🐡🐡🐡${response.body}");
        return response.statusCode==200;
       }


       Future<bool> editDiscription({required String serverId,  String? discription})async{
         final url = Uri.parse("${EndPoint.baseUrl}/server/description");
         final accessToken = await storage.readSecureData('AccessToken'); 
          

          try {
            final body = {
            "ServerID": serverId,
            "Description": discription
          };

         final response = await http.patch(
          url,
          headers: {
            "Content-Type":"application/json",
            "AccessToken":accessToken,
          },
          body: jsonEncode(body)
          );
          log("🐥🐥🐥${response.body}");
          return response.statusCode==200;
          } catch (e) {
            log(e.toString());
          }
         return false;
       }


       Future<List<SearchAllServerModel>?>searchAllServers(String? searchTxt)async{ 
        final url =Uri.parse("${EndPoint.baseUrl}/server/search?name=$searchTxt&Page=1&Limit=20");     
        final accessToken = await storage.readSecureData('AccessToken'); 
      try {

      final respose = await http.get(
        url, 
        headers: {   
          "AccessToken":accessToken,  
        },
        );
         
        log(" 🎁🎁🎁${respose.body}");
         if (respose.statusCode==200) {
            final jsonData = jsonDecode(respose.body);
        List<dynamic> friendsJsonList = jsonData['result']['servers'];  
 
          List<SearchAllServerModel> servers = friendsJsonList.map((json)  { 
           return SearchAllServerModel.fromJson(json);  
          }).toList(); 
          return servers;
 
        } 
 
      } catch (e) {
        log(e.toString());
      }
       return null;
   }
      
      Future<bool>joinServer(String serverId)async{
         final url =Uri.parse("${EndPoint.baseUrl}/server/join");     
         final accessToken = await storage.readSecureData('AccessToken'); 

        final body = {
          "serverID":serverId
        };
          try {
             final response = await http.post(
              url,
              headers: {
                 "AccessToken":accessToken,
                 "Content-Type":"application/json",
              },
              body: jsonEncode(body)
              );

              log("🔔🔔🔔${response.body}");
            return response.statusCode==200;

          } catch (e) {
            log(e.toString());
          }
          return false;
      }


       Future<List<ChannelModel>?>getAllChannelsAndCategory(String serverID)async{
           final url = Uri.parse("${EndPoint.baseUrl}/server/channel?serverID=$serverID");     
           final accessToken = await storage.readSecureData('AccessToken'); 

           try {
             
             final response = await http.get(
              url,
              headers: {
                 "AccessToken":accessToken,
                 "Content-Type":"application/json",
              },
              );  
              log("✨✨✨${response.body}");
              if (response.statusCode==200) {
                final parsed = jsonDecode(response.body)['result']['Data'];
                List<ChannelModel> categories = [];
                for (var item in parsed) {
                List<Channel> channels = [];
                if (item['channel'] != null) {
                  channels = List<Channel>.from(item['channel'].map((x) => Channel.fromJson(x)));
                }
                categories.add(ChannelModel(
                  categoryId: item['CategoryID'],
                  name: item['Name'],
                  channels: channels,
                ));
              }   
              
              
              return categories;      
              }

           } catch (e) {
             log(e.toString());
           }
           return null;
       }





     
  }

