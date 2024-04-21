
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'widgets/personal_chat.dart';

class ScreenMessages extends StatelessWidget {
  const ScreenMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Messages',style: kAppBarHedingStyke,),
      ),
     body:ListView.separated(
     itemBuilder:(context, index) {
       return GestureDetector(
        onTap: () {
          kNavigationPush(context,const PersonalChat()); 
        },
         child: ListTile(
            leading: InstaImageViewer(
              child: CircleAvatar(
                radius: 25 ,
                backgroundImage:
                //  data.profilePhoto != null
                //     ? NetworkImage(data.profilePhoto!)
                //     :
                  AssetImage(kDefaultProfilePic) as ImageProvider, 
              ),
            ),
            title:const Text(
              "data.name",
              style: TextStyle(fontSize: 18),
            ),
            subtitle:const Text("data.userName ?? ''"),
              trailing:const Text('1 m'),
          ),
       );
     },
     separatorBuilder: (context, index) =>const Divider(thickness: 0.2,), 
     itemCount: 7 
     ),
    );
  }
}