import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/chat_other_widget.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/chat_self_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PersonalChat extends StatelessWidget {
  const PersonalChat({super.key}); 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 246, 243, 243) ,
      appBar:AppBar(
       leading:IconButton( 
        onPressed: (){
          Navigator.pop(context); 
        },
        icon:const Icon(Icons.arrow_back)),
       title:Row(
        children: [
        const CircleAvatar(), 
        kWidth15,
        const Text('Kevin',)
        ],
       ),
       actions: [
         IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.phone_fill,
              color: kClrBlue,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.video_camera_solid,
              color: kClrBlue,
            ),
          ), 
       ],
      ) ,
      body: Column(
        children: [
          
          Expanded(
            child: ListView( 
                    children: [   
            kHeight10,
                     const Center(child:  Text('16/4/2024')), 
                    const ChatTexOtherstWidget(chatTxt: "hy iam kevin"),
                     const ChatTexOtherstWidget(chatTxt: "ime throug"),
            const ChatTexOtherstWidget(chatTxt: "ime throug"),
             const ChatTexOtherstWidget(chatTxt: "ime throug"), 
                    const ChatTxtSelf(chatTxt: " Audio calls are a fundam"),
                    const ChatTxtSelf(chatTxt: " Audio calls are a fundam"), 
                     const ChatTexOtherstWidget(chatTxt: "ime throug"), 
            const ChatTexOtherstWidget(chatTxt: "ime throug"), 
             const ChatTxtSelf(chatTxt: " Audio calls are a fundam"), 
                    const ChatTxtSelf(chatTxt: " Audio calls are a fundam"), 
                            const ChatTexOtherstWidget(chatTxt: "ime throug"), 
            const ChatTexOtherstWidget(chatTxt: "ime throug"), 
             const ChatTxtSelf(chatTxt: " Audio calls are a fundam"), 
                    const ChatTxtSelf(chatTxt: " Audio calls are a fundam"), 
                
                   ],
                   
                  ),
          ), 
          SizedBox(
            height: 70 ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration:const InputDecoration(
                  filled: true,
                  fillColor:kClrWhite, 
                 suffixIcon: Icon(Icons.send,color: kClrBlue,),
                  hintText: 'Message',  
                  border: OutlineInputBorder(
                   borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  )
                ), 
              ),
            ),
          )
        ],
      )
    );
  }
}




