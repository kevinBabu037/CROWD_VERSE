import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:flutter/material.dart';
import '../authentication/signup/screen_signup.dart';


class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  
   @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenSignup(),)); 
    });
    super.initState();
  }

 
  @override 
  Widget build(BuildContext context) { 
    Size screenSize = MediaQuery.of(context).size; 
    return  Scaffold( 
     backgroundColor:const Color(0xFF171B24),
       
     body: Center(   
      child:SizedBox( 
        height: screenSize.height*0.3,  
        width: screenSize.width* 0.6,   
        child: Image.asset(kAppLogo),  
      ), 
     ),
    );
  }
}