import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:flutter/material.dart';

class ChatTextOtherstWidget extends StatelessWidget {
  const ChatTextOtherstWidget({
    super.key,
     required this.chatTxt,
     required this.data
  });
  final String chatTxt;
final FriendsModel data;  
  @override
  Widget build(BuildContext context) {
    
    return Row(
     children:[  
      kWidth15,
      CircleAvatar( 
      backgroundImage:data.profilePhoto!=null? NetworkImage(data.profilePhoto!):AssetImage(kDefaultProfilePic)as ImageProvider ,
       radius: 12,
     ),
     
      Flexible(
        child: Container(
  
          margin:const EdgeInsets.symmetric(horizontal: 15,vertical:7),  
         decoration: BoxDecoration(
            color:kClrWhite, 
            borderRadius: BorderRadius.circular(20)   
        ),
         child: Padding(
           padding: const EdgeInsets.all(10),
           child: Text(chatTxt,style:const TextStyle(fontSize: 16 ),),
         ) ,
        ),
      ),
     
     ],
    );
  }
}