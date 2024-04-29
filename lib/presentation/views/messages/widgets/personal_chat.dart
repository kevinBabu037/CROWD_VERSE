

import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/views/messages/message_bloc/bloc/friendly_message_bloc.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/chat_other_widget.dart';
import 'package:crowd_verse/presentation/views/messages/widgets/chat_self_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PersonalChat extends StatefulWidget {
 final FriendsModel data;
  const PersonalChat({
    super.key, 
    required this.data,
   
    });   

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}
 FriendlyChatService service =FriendlyChatService();
 TextEditingController messageController =TextEditingController();

  
class _PersonalChatState extends State<PersonalChat> {
   
   ScrollController scrollController =ScrollController(); 
  
  @override
  void initState() {
    super.initState();
   context.read<FriendlyMessageBloc>().add(GetAllMessagesEvent(userId:widget.data.userId!));

  }
 

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
         CircleAvatar(
          backgroundImage:widget.data.profilePhoto!=null?NetworkImage(widget.data.profilePhoto!):
            AssetImage(kDefaultProfilePic)as ImageProvider
        ),   
        kWidth15,
         Text(widget.data.name,)
        ], 
       ),
      ) , 
      body: Column( 
        children: [ 

          Expanded(
            child: BlocBuilder<FriendlyMessageBloc, FriendlyMessageState>( 
           
              builder: (context, state) { 
                if (state is FriendlyMessageLoaddingState) {
                return  const   Center(child: CircularProgressIndicator(),);
                }
              if (state is FriendlyMessageSuccessState) { 
                 WidgetsBinding.instance.addPostFrameCallback((_) { 
                  scrollController.jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return ListView.builder(
                        controller: scrollController,
                          itemCount: state.model!.length,  
                          itemBuilder: (BuildContext context, int index) { 
                            final data = state.model![index];
                            if (data.senterId==widget.data.userId){ 
                              return ChatTextOtherstWidget(chatTxt:data.message,data:widget.data,chat: data,);
                             }else{
                              return ChatTxtSelf(chatTxt:data.message);
                            }
                          },
                        );            
              }
              if (state is FriendlyMessagEmptyState) {
                return const Center(child: Text('no messages'),);
              }  
              return const SizedBox(); 
              },
            ), 
          ), 
          SizedBox(
            height: 70 ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( 
                controller: messageController,
                decoration: InputDecoration(
                  filled: true, 
                  fillColor:kClrWhite, 
                 suffixIcon: IconButton( 
                  onPressed: ()async{
                     if (messageController.text.trim().isNotEmpty){
                       String senderId = await SecureStorage().readSecureData('UserID');
                       // ignore: use_build_context_synchronously
                        service.sendMessage(widget.data.userId!, messageController.text,context);

                       final chat = FriendlyChatModel(time:DateTime.now().toString(), message: messageController.text, senterId:senderId , resrverId: widget.data.userId!);

                       // ignore: use_build_context_synchronously
                       context.read<FriendlyMessageBloc>().add(SendMessageEvent(chat:chat ));
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      messageController.clear();  
                     } 
                  }, 
                  icon:const Icon(Icons.send,)),
                  hintText: 'Message',  
                  border:const OutlineInputBorder(
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
 

 





 