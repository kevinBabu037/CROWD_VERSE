
import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:flutter/material.dart';

class ChatTextOtherstWidget extends StatelessWidget {
  const ChatTextOtherstWidget({
    super.key,
     required this.chatTxt,
     required this.data,
     required this.chat
  });
  final String chatTxt;
 final FriendsModel data;
 final FriendlyChatModel chat;  
  @override
  Widget build(BuildContext context) {
    String time = kMessageTimeConverter(chat.time);   
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
            borderRadius: BorderRadius.circular(15 )    
        ),
         child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [ 
            Padding(
           padding: const EdgeInsets.only(left: 20,right: 20,top: 10 ), 
           child: Text(chatTxt,style:const TextStyle(fontSize: 16 ),),
          ),
           Padding( 
             padding: const EdgeInsets.all(8.0),
             child: Text(time,style:const TextStyle(fontSize: 11 ,color: kClrGrey),),
           ) 
          ],
         )
        ), 
      ),  
         
        
     ],
    );
  }
}