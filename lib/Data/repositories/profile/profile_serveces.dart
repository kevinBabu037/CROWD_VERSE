
import 'dart:convert';
import 'dart:developer';
import 'package:crowd_verse/data/models/profile/public_profile_model.dart';
import 'package:crowd_verse/presentation/utils/core/endpoints.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/profile/profile_modle.dart';

class ProfileServices{
  
  SecureStorage storage = SecureStorage();


 Future<ProfileModel?> getUserDetails()async{
    final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.profile}") ;
   final accessToken = await storage.readSecureData('AccessToken'); 
    try {
      final response=await http.get( 
        url, 
        headers: {
          "AccessToken":accessToken,
        } 
        );  
      log("data from get profile:${ response.body}"); 
       if (response.statusCode==200) {
         final jsonDecoded= jsonDecode(response.body);
         final model= ProfileModel.fromJson(jsonDecoded['result']);
         return model; 
       }
    
  
    } catch (e) {
      log(e.toString()); 
    }
   return null;

  }

 ///////////////////////

  Future<bool>  deleteStatus()async{
       final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.profileStatus}") ; 
   final accessToken = await storage.readSecureData('AccessToken'); 
  
   final body={
    "Status":" ",
    "Duration":1
   };

    try {
      final response=await http.post( 
        url, 
        headers: {
          "AccessToken":accessToken,  
        },
           
        body: jsonEncode(body)     
        );  
      log("data from get profile Status delet:${ response.body}"); 
 
       if (response.statusCode==200) {
         return true;
       }
 
    } catch (e) {
      log(e.toString());
    }
     return false;

    }


  ////////////////////////
    

   Future<int> uploadCoverPic(String imgPath)async{
     
   final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadCoverphoto}") ; 
   final accessToken = await storage.readSecureData('AccessToken'); 

    final header={
          "Content-Type":"multipart/form-data", 
          "AccessToken":accessToken,
        };

     try {
       var request = http.MultipartRequest('POST', url);
          request.headers.addAll(header);
          request.files.add( 
            await http.MultipartFile.fromPath( 
            'CoverPhoto',
            imgPath 
          ), 
          );
          final response = await request.send(); 

          

          log("cover pic🍿${response.statusCode}");  
          return response.statusCode;


     } catch (e) {
        log(e.toString()); 
     }
     return -1;

   }


   /////////////////


    Future<int> uploadProfilePic(String imgPath)async{
     
   final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadProfilephoto}") ; 
   final accessToken = await storage.readSecureData('AccessToken');  

    final header={
          "Content-Type":"multipart/form-data", 
          "AccessToken":accessToken,
        };

     try {
       var request = http.MultipartRequest('PATCH', url);  
          request.headers.addAll(header); 
          request.files.add( 
            await http.MultipartFile.fromPath( 
            'ProfilePhoto',
            imgPath 
          ), 
          );
          final response = await request.send(); 

          

          log("profile pic💕${response.statusCode}");  
          return response.statusCode;


     } catch (e) {
        log(e.toString());  
     }
     return -1;

   }


   ///////////////////////

  
   Future<void> addDiscription(String about)async{
   final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadDiscription}");
   final accessToken = await storage.readSecureData('AccessToken'); 
   final body ={
     "Description":about 
   };

    try {    
      final response=await http.post( 
        url,   
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        }, 
        body: jsonEncode(body)
        );  

     log("discription👌:${ response.body}"); 
   
    } catch (e) { 
      log(e.toString()); 
    }

  }

  Future<void> deleteDiscription()async{
   final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadDiscription}");
   final accessToken = await storage.readSecureData('AccessToken'); 
   final body ={
     "Description":'' 
   };

    try {    
      final response=await http.post( 
        url,   
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        }, 
        body: jsonEncode(body)
        );  

     log("discription👌:${ response.body}"); 
   
    } catch (e) { 
      log(e.toString()); 
    }

  }
    


     Future<bool> addStatus(String text)async{
   final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.uploadStatus}");
   final accessToken = await storage.readSecureData('AccessToken'); 
   final body ={
     "Status":text ,
     "Duration":24
   };
  
    try {    
      final response=await http.post( 
        url,   
        headers: {  
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        }, 
        body: jsonEncode(body) 
        );  

     log("Status😶‍🌫️:${ response.body}");  

     if (response.statusCode==200) {
       return true;
     }  
   
    } catch (e) { 
      log(e.toString()); 
    }
    return false;

  } 

    Future<bool>deleteProfilrandCoverPic(String type)async{
        final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.deleteProfileAndCoverPic}");
   final accessToken = await storage.readSecureData('AccessToken'); 
    final body={
    "Type" :type
    };
    

     try {

      final response = await http.delete(
        url,
        body: jsonEncode(body),
        headers: { 
          "Content-Type": "application/json",
          "AccessToken":accessToken,  
        }, 
        );
        log("delete profile pic and cover ${response.body}");
        if (response.statusCode==200) {
          return true; 
        }
       
     } catch (e) {
       log(e.toString());
     }
     return false; 
    
    }


    Future<PublicProfileModel?> publicUserAllDetails(String id)async{
    final url =Uri.parse("${EndPoint.baseUrl}/profile/$id") ;
   final accessToken = await storage.readSecureData('AccessToken'); 
    try {
      final response=await http.get( 
        url, 
        headers: {
          "AccessToken":accessToken,
        } 
        );  

      log("publicprofile🚒🚒🚒🚒🚒:${ response.body}"); 
       if (response.statusCode==200) {
         final jsonDecoded= jsonDecode(response.body);
         final model= PublicProfileModel.fromJson(jsonDecoded['result']);
         return model; 
       }
    
  
    } catch (e) {
      log(e.toString()); 
    }
   return null;

  }


  


 
}