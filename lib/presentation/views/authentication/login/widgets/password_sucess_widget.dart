import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/presentation/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';

import '../screen_login.dart';


class PasswordSucessWidget extends StatelessWidget {
  const PasswordSucessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(height: 100, 
           width: 100, 
          child: Image.asset('assets/sucess.png',fit: BoxFit.cover,)), 
         const LoginSignUpHedingWidget(
          crossAxisAlignment: CrossAxisAlignment.center,
            title: 'Password Changed!',
             text: 'Your password has been changed successfully.'
             ),
             SizedBox(height: kHeight60,),
             LoginSignUpButtonWidget( 
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const ScreenLogIn() ,), (route) => false);
              },
              text: 'Back to Login')
          ],
        )     
      ),
    );
  }
}