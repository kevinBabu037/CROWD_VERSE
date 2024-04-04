import 'package:crowd_verse/Application/core/color.dart';
import 'package:crowd_verse/Application/core/functions.dart';
import 'package:crowd_verse/Application/screens/Authentication/login/screen_login.dart';
import 'package:flutter/material.dart';

class AlredyHaveAccWidget extends StatelessWidget {
  const AlredyHaveAccWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
     children: [
      const Text('Already have an account?'),
       GestureDetector( 
         onTap: () {
            kNavigationPush(context,const ScreenLogIn());
         },
         child: const Text(' Login',style: TextStyle(color: kClrBlue),),
         ),
                   
     ],
       );
  }
}