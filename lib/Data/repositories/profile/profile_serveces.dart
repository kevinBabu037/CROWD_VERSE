
import 'dart:convert';
import 'dart:developer';

import 'package:crowd_verse/utils/core/endpoints.dart';
import 'package:crowd_verse/data/models/profile/profile_modle.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfileServices{

 Future<ProfileModel?> getUserDetails()async{
    final url =Uri.parse("${EndPoint.baseUrl}${EndPoint.profile}") ;
   final accessToken = await SecureStorage().readSecureData('AccessToken'); 
   final refreshToken = await SecureStorage().readSecureData('RefresToken');
    try {
      final response=await http.get(
        url, 
        headers: {
          "AccessToken":accessToken,
          "RefreshToken":refreshToken
        } 
        );  
      log("data from get profile:${ response.body}"); 
 
     if(response.statusCode==200){
      final jsonDecoded=jsonDecode(response.body);
       
         return ProfileModel.fromJson(jsonDecoded['result']);
     }
 
    } catch (e) {
      log(e.toString());
    }
   return null;

  }

}