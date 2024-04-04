import 'package:crowd_verse/Application/core/height_width.dart';
import 'package:crowd_verse/Application/screens/nav_bar/nav_bar.dart';
import 'package:crowd_verse/Application/widgets/login_signup_button.dart';
import 'package:crowd_verse/Application/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../Data/Auth/auth_service.dart';

class EmailverifyWidget extends StatelessWidget {
  const EmailverifyWidget({super.key, required this.token});
  final String token;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding:const EdgeInsets.symmetric(horizontal: 15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Lottie.network('https://lottie.host/e5b15edb-bfe6-471e-87db-389f339fc1b1/O7YLxAYV5j.json'),
              
           const Center(child: LoginSignUpHedingWidget(
              title: 'Check Your Email', 
               text: "Please check your inbox for a confirmation message to proceed."
               )),
               LoginSignUpButtonWidget(
                onPressed: ()async{
               final res=  await SignUpService().confirmMail(token); 
                   if(res.isNotEmpty){
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const ScreenNavBar(),), (route) => false);
                   }
                }, text: "Next"
                ),
               SizedBox(height:kHeight50)  
          ],
        ),
      ) ,
    );
  }
}