

import 'package:crowd_verse/Application/screens/Authentication/login/screen_login.dart';
import 'package:crowd_verse/Data/Sharedprefrense/shared_prefrense.dart';
import 'package:flutter/material.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Column(mainAxisAlignment: MainAxisAlignment.center,
       children: [
        ElevatedButton(onPressed: ()async{
         await SharedPreferenses.deleteBool();
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const ScreenLogIn(),), (route) => false);
        },
         child:const Text('Logout')), 
        const Center(child: Text('profile'),),
       ],
     ),
    );
  }
}