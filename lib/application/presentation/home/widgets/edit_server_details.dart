
import 'dart:io';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/edit_server/bloc/edit_server_bloc.dart';
import 'package:crowd_verse/application/presentation/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

editServerDetails(
  {
    required BuildContext context,
    required String serverId
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
                   title:const Text("Edit Server"),
                   content: SizedBox(    
                    height: 250,  
                     child: Column(  
                      children: [ 
                       const Text('Access only for admin'),  
                       kHeight10,
                      BlocBuilder<EditServerBloc, EditServerState>(
                         builder: (context, state) {
                           if (state is ImagePickingSuccessstate) {
                             return CircleAvatar(
                               backgroundImage: FileImage(File(state.imagePath)),
                               radius: 50,
                             );
                           } else {
                             return GestureDetector(
                               onTap: () {
                                 context.read<EditServerBloc>().add(ImagePickingEvent());
                               },
                               child:const CircleAvatar(
                                 radius: 50,
                                 child: Icon(Icons.add_a_photo),
                               ),
                             );
                           }
                         },
                      ),
                       kHeight20, 
                       kShowDialogTextField( 
                      statusController: controller,  
                      hintTxt: 'Discription'       
                      ),  
                      ], 
                      ),
                   ),
                   actions: [  
                    TextButton(onPressed:(){
                      Navigator.pop(context); 
                    }, 
                     child:const Text('cancel')), 
                    BlocConsumer<EditServerBloc, EditServerState>(
                      listener: (context, state) {
                        if (state is EditServerImageSuccessState) {
                          kSnakBar(context, 'content', kClrLiteGreen);
                        }
                      },
                      builder: (context, state) {
                        return TextButton(
                                 onPressed: (){
                                 context.read<EditServerBloc>().add(UploadImageEvent(serverId:serverId,discription: controller.text));
                                kNavigationPushReplacement(context,const ScreenNavBar());
                               },
                               child:const Text('Save'));
                      },
                    )
                 
                   ],
                 ),
               ); 
             },
             );
} 
