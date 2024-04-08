import 'package:crowd_verse/utils/core/functions.dart';
import 'package:flutter/material.dart';

import '../../../../data/sharedprefrense/shared_prefrense.dart';
import '../../authentication/login/screen_login.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title:const Text("Settings"), 
      ),
      body: Column(
        children: [
          IconButton(onPressed: ()async{
            await SharedPreferenses.deleteBool();
           kNavigationPushRemoveUntil(context,const ScreenLogIn());
          },
           icon:const Icon(Icons.logout))
        ],
      ),
    );
  }
}