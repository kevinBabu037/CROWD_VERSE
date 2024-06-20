

import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:flutter/material.dart';

class ChatTxtSelf extends StatelessWidget {
  const ChatTxtSelf({
    super.key,
     required this.data,
  }); 
 final FriendlyChatModel data;
 
  @override
  Widget build(BuildContext context) {
    String time = kMessageTimeConverter(data.time);  
    return Row(mainAxisAlignment: MainAxisAlignment.end,
     children:[ 
      Flexible(  
        child: Container( 
      
          margin:const EdgeInsets.symmetric(horizontal: 15,vertical:7),
         decoration: BoxDecoration( 
            color:kClrBlue, 
            borderRadius: BorderRadius.circular(15)   
        ),
         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding( 
               padding: const EdgeInsets.all(10),  
                child: Text(data.message,style:const TextStyle(fontSize: 16,color: kClrWhite ),),
             ),
              Padding( 
                 padding: const EdgeInsets.all(8.0),
                 child: Text(time,style:const TextStyle(fontSize: 11 ,color: kClrWhite),),
               ) 
           ],
         ) ,
        ), 
      ),
       
     ],
    );
  }
}