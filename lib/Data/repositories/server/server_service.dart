
import 'dart:convert';
import 'dart:developer';

import 'package:crowd_verse/data/models/server/all_server_model.dart';
import 'package:crowd_verse/data/models/server/server_details.dart';
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
     final url =Uri.parse("${EndPoint.baseUrl}/server/$serverId");
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

     Future<void> getAllChannels()async{
      final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.getAllChannels}");
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
          // final decodedJson = jsonDecode(response.body);
          
          
        }
 
     } catch (e) {
       log(e.toString());
     }
       
     }





     }

