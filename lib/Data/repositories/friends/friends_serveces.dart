
import 'dart:convert';
import 'dart:developer';

import 'package:crowd_verse/data/models/friends/block_list_model.dart';
import 'package:crowd_verse/data/models/friends/friend_requests.dart';
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/data/models/friends/search_all_user.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:crowd_verse/presentation/utils/core/endpoints.dart';
import 'package:http/http.dart' as http;

class  FriendsServeses {

     SecureStorage storage =SecureStorage() ;

  
  
   Future<List<FriendsModel>?>getAllFriends()async{
   final url =Uri.parse("${EndPoint.baseUrl}/friend/friends?page=1&limit=12"); 
   final accessToken = await storage.readSecureData('AccessToken'); 

       try {
          
        final response = await http.get(
          url, 
          headers: { 
          "AccessToken":accessToken,  
         }, 
        );

        log("response of get all friends 👽: ${response.body}");

        if (response.statusCode==200) {
            final jsonData = jsonDecode(response.body);
        List<dynamic> friendsJsonList = jsonData['result']['Friends']; 
 
          List<FriendsModel> friends = friendsJsonList.map((json)  { 
          return FriendsModel.fromJson(json);  
          }).toList(); 
            
          return friends;

        } 
  

       } catch (e) {
         log(e.toString());   

       } 
       return null;
     
   }



    Future<List<FriendRequestsModel>?>getAllRequests()async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/friend/received?page=1&limit=5");    
   final accessToken = await storage.readSecureData('AccessToken'); 

       try {
          
        final response = await http.get(    
          url,
          headers: { 
          "AccessToken":accessToken,  
         }, 
        );
       
        log("response of frindrequest resived😊😊😊: ${response.body}");
          
        if (response.statusCode==200) {
           
            final jsonData = jsonDecode(response.body);
        List<dynamic> friendsJsonList = jsonData['result']['Received']; 
 
          List<FriendRequestsModel> friendRequest = friendsJsonList.map((json)  { 
          return FriendRequestsModel.fromJson(json);  
          }).toList();
 
          return friendRequest;  

        }  
 

       } catch (e) {
         log(e.toString());  
       }   
       return null;

 
   }

    Future<bool>requstAcceptOrReject(String acceptOrReject,String friendshipId)async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/friend/friendrequest?action=$acceptOrReject");    
   final accessToken = await storage.readSecureData('AccessToken'); 
       
    final body ={
    "FrendShipID" :friendshipId
    };


      try {

      final respose = await http.patch(
        url, 
        body: jsonEncode(body),
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        },
        );
         
         log(" 🤖🤖🤖🤖🤖${respose.body}");
        if (respose.statusCode==200) {
          return true; 
        }



        
      } catch (e) {
        log(e.toString());
      }
      return false;


    }




    Future<List<FriendRequestsModel>?>requstSendedList()async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/friend/send?page=1&limit=10");    
   final accessToken = await storage.readSecureData('AccessToken'); 

      try {

      final respose = await http.get(
        url, 
        headers: {   
          "AccessToken":accessToken,  
        },
        );
         
        
         if (respose.statusCode==200) {
            final jsonData = jsonDecode(respose.body);
        List<dynamic> friendsJsonList = jsonData['result']['Send'];  
 
          List<FriendRequestsModel> friends = friendsJsonList.map((json)  { 
          return FriendRequestsModel.fromJson(json);  
          }).toList(); 
          return friends;
 
        } 
 
      } catch (e) {
        log(e.toString());
      }
      return null;

    }





     Future<bool>removeFromPending(String friendshipId)async{ 
    final url =Uri.parse("${EndPoint.baseUrl}/friend/friendrequest?action=revoke");    
   final accessToken = await storage.readSecureData('AccessToken'); 
       
    final body ={
    "FrendShipID" :friendshipId
    };


      try {

      final respose = await http.patch(
        url, 
        body: jsonEncode(body),
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        },
        );
         
         log("😈😈😈😈${respose.body}");
        if (respose.statusCode==200) {
          return true; 
        }



        
      } catch (e) {
        log(e.toString());
      }
      return false;


    }



   Future<List<SearchAllUserModel>?>searchAllFriends(String? searchTxt)async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/users?username=$searchTxt&page=1&limit=15");     
   final accessToken = await storage.readSecureData('AccessToken'); 
      try {

      final respose = await http.get(
        url, 
        headers: {   
          "AccessToken":accessToken,  
        },
        );
         
        log(" 👻👻👻👻${respose.body}");
         if (respose.statusCode==200) {
            final jsonData = jsonDecode(respose.body);
        List<dynamic> friendsJsonList = jsonData['result']['users'];  
 
          List<SearchAllUserModel> friends = friendsJsonList.map((json)  { 
          return SearchAllUserModel.fromJson(json);  
          }).toList(); 
          log("👾👾👾👾 $friends");
          return friends;
 
        } 
 
      } catch (e) {
        log(e.toString());
      }
      return null;
   }



   Future<bool>followFriend(String friendId)async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/friend/request");    
   final accessToken = await storage.readSecureData('AccessToken'); 
       
    final body ={
    "FriendID" :friendId
    };


      try {

      final respose = await http.post(
        url, 
        body: jsonEncode(body),
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        },
        );
         
         log("create friend: ${respose.body}");
       
          if (respose.statusCode==200) {
            return true;
          }
        

        
      } catch (e) {
        log(e.toString());
      }
      return false;


    }

     Future<bool>blockOrUnBlock(String friendshipId,String blockOrUnBloc)async{ 
   final url =Uri.parse("${EndPoint.baseUrl}/friend/restrict?action=$blockOrUnBloc");    
   String accessToken = await storage.readSecureData('AccessToken'); 
       
    final body ={
    "FrendShipID" :friendshipId
    };


      try {

      final respose = await http.patch(
        url, 
        body: jsonEncode(body),
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        },
        );
         
         log("block user: ${respose.body}");
        if (respose.statusCode==200) {
          return true; 
        }



        
      } catch (e) {
        log(e.toString());
      }
      return false;

    }

    Future<List<BlockListModel>?>getAllBlockList()async{
   final url =Uri.parse("${EndPoint.baseUrl}/friend/block?page=1&limit=10"); 
   final accessToken = await storage.readSecureData('AccessToken'); 

       try {
          
        final response = await http.get(
          url,
          headers: { 
          "AccessToken":accessToken,  
         }, 
        );

        log("bloc List: ${response.body}");

        if (response.statusCode==200) {
            final jsonData = jsonDecode(response.body);
        List<dynamic> friendsJsonList = jsonData['result']['Block']; 
 
          List<BlockListModel> friends = friendsJsonList.map((json)  { 
          return BlockListModel.fromJson(json);  
          }).toList(); 
            
          return friends;

        } 
  

       } catch (e) {
         log(e.toString());   

       } 
       return null;
     
   }


} 