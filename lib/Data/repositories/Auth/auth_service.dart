import 'dart:convert';
import 'dart:developer';
import 'package:crowd_verse/utils/core/endpoints.dart';
import 'package:crowd_verse/data/sharedprefrense/shared_prefrense.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../models/auth/user.dart';
  
class AuthService {


////////////////



  Future <Response?> createUser(UserModel user) async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.signUp}');

    final body = {
      "UserName": user.userName,
      "Name": user.name, 
      "Email": user.eMail,
      "Password": user.password,
    }; 

    try { 
      final response = await http.post(
        url, 
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      log(response.body);

 
     return response;
  
    } catch (error) {
      log('Error occurred: $error');
    }
     return null;
    
  }
  
  ///////////////////
  
   Future<bool> confirmMail(String confirmToken) async {
   final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.confirmMail}');

   try {
     final response = await http.post(
    url,
    headers: {"ConfirmToken": confirmToken},
  ); 
  log(response.body);

  if (response.statusCode == 201) {
    await  SharedPreferenses.saveBoolValue(true);
    final jsonResponse = jsonDecode(response.body);
     String accessToken  = jsonResponse['result']['AccessToken'];
     String refreshToken  = jsonResponse['result']['RefresToken'];
     SecureStorage().writeSecureData("AccessToken", accessToken);
     SecureStorage().writeSecureData("RefresToken", refreshToken);
    return true;
  } 
   } catch (e) { 
     log(e.toString());
   }
   return false;

}

////////////////////

 Future<bool> userLogin(String email ,String password)async{
  final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.login}');
      final body={
        "Email":email,
        "Password":password
      };
     try {
       final response=await http.post(
      url,
       headers: { 
          'Content-Type': 'application/json',
        },
        body:jsonEncode(body)
      );
      log(response.body);

      if(response.statusCode==201){
        final json=jsonDecode(response.body); 
         String accessToken=json['result']['AccessToken'];
         String refreshToken=json['result']['RefresToken'];

         await SecureStorage().writeSecureData('AccessToken', accessToken); 
         await SecureStorage().writeSecureData('RefresToken', refreshToken);
         await SharedPreferenses.saveBoolValue(true); 
        return true;
      }
      
     } catch (e) {
       log(e.toString());
     } 
     return false;
  
 }

/////////////////
 
 Future<Response?> resetPasswordConfirmMail(String mail)async{
      final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.resetPassConfirmMail}');
      final body={
        'Email':mail
      };
      try {
        final response= await http.post(
          url, 
          headers: {
          'Content-Type': 'application/json',
        }, 
        body: jsonEncode(body)
        );
       log(response.body);

       
        if (response.statusCode==201) {
            final json=  jsonDecode(response.body);
            String forgotPassToken=json['result']['Token'];
            SecureStorage().writeSecureData('forgotPassToken', forgotPassToken);

        }
        return response;
 
      } catch (e) {
        log(e.toString());
      }
      return null;
      
 }


 ////////////////////


 Future<bool> resetPassword(String password ,String otp)async{
   
   final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.forgotPass}');
   final body={
    "Password":password,
    "Otp" :otp
   };
   String token=await SecureStorage().readSecureData('forgotPassToken');
   try {
      final response=await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "ConfirmToken" :token
        },
        body: jsonEncode(body)
        );

       log(response.body);
       
       if(response.statusCode==201){
        return true;
       }

   } catch (e) {
     log(e.toString());
   }
   return false;


 }



}
