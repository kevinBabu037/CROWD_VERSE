import 'dart:convert';
import 'dart:developer';
import 'package:crowd_verse/Application/core/endpoints.dart';
import 'package:crowd_verse/Data/Sharedprefrense/shared_prefrense.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
  
class SignUpService {


////////////////



  Future <String> createUser(UserModel user) async {
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

      log(response.statusCode.toString());
      log(response.body);
       
       if(response.statusCode==201){

          final jsonResponse=jsonDecode(response.body);
       
       String token =jsonResponse['result']['TemperveryToken'];

       return token;
            
       }
     
       

    } catch (error) {
      log('Error occurred: $error');
    }
    return '';
    
  }
  
  ///////////////////
  
   Future<List<String>> confirmMail(String token) async {
   final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.confirmMail}');

   try {
     final response = await http.post(
    url,
    headers: {"ConfirmToken": token},
  ); 
  log(response.body);

  if (response.statusCode == 201) {
    final jsonResponse = jsonDecode(response.body);
    final accessToken = jsonResponse['result']['AccessToken'];
    final refreshToken = jsonResponse['result']['RefresToken'];
    return [accessToken, refreshToken,'success'];
  } 
   } catch (e) { 
     log(e.toString());
   }
   return [];

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
         await SharedPreferenses.saveBoolValue(true);
        return true;
      }
      
     } catch (e) {
       log(e.toString());
     } 
     return false;
  
 }


 
 Future<String> resetPasswordConfirmMail(String mail)async{
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

        if(response.statusCode==201){
          final json=jsonDecode(response.body);
             String token=json['result']['Token'];
             return token;
        }
     
       

      } catch (e) {
        log(e.toString());
      }
      return '';
      
 }

 Future<void> resetPassword(String password ,String otp,String token)async{
   
   final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.forgotPass}');
   final body={
    "Password":password,
    "Otp" :otp
   };
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

   } catch (e) {
     log(e.toString());
   }


 }



}
