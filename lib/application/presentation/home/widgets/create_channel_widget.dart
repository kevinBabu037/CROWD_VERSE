import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/validations/validation.dart';
import 'package:flutter/material.dart';

showDialogToCreateChannel(
  {required BuildContext context,
   required String serverID,
   required String categoryID,

  }
){
    showDialog(
            context: context,
             builder: (context) {
                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
              TextEditingController controller = TextEditingController();
               return Form(
                key:formKey ,
                 child: AlertDialog(
                   title:const Text("Create Channel"),
                   content:kShowDialogTextField( 
                    validator: (value) {
                      return kServerNameValidation(value);  
                    },  
                     statusController: controller, 
                      hintTxt: 'Channel name'        
                      ), 
                   actions: [ 
                    Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: (){  
                          Navigator.pop(context);     
                        }, 
                         child:const Text("Cancel")),
                         TextButton( 
                            onPressed:()async{
                           if (formKey.currentState!.validate()&& controller.text.trim().isNotEmpty) {
                             bool res = await ServerService().createChannel(serverId: serverID, channelName: controller.text, catogoryID:categoryID);
                             // ignore: use_build_context_synchronously
                             res == true ? kSnakBar(context, 'Channel Created', kClrLiteGreen):kSnakBar(context, 'Fail to create', kClrLiteRed);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);             
                            }
                           },
                           child:const Text("Create"))
                      ],
                    ),
                     
                 
                   ],
                 ),
               ); 
             },
             );
} 
