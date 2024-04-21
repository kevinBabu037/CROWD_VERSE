import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:flutter/material.dart';

class ChatTexOtherstWidget extends StatelessWidget {
  const ChatTexOtherstWidget({
    super.key,
     required this.chatTxt,
  });
  final String chatTxt;

  @override
  Widget build(BuildContext context) {
    return Row(
     children:[ 
      kWidth15,
     const CircleAvatar( 
       radius: 15,
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