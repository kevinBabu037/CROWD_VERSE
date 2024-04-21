

import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:flutter/material.dart';

class ChatTxtSelf extends StatelessWidget {
  const ChatTxtSelf({
    super.key,
     required this.chatTxt,
  }); 
  final String chatTxt;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end,
     children:[ 
      Flexible(  
        child: Container( 
      
          margin:const EdgeInsets.symmetric(horizontal: 15,vertical:7),
         decoration: BoxDecoration(
            color:kClrBlue, 
            borderRadius: BorderRadius.circular(20)   
        ),
         child: Padding( 
           padding: const EdgeInsets.all(10),  
           child: Text(chatTxt,style:const TextStyle(fontSize: 16,color: kClrWhite ),),
         ) ,
        ), 
      ),
       
     ],
    );
  }
}