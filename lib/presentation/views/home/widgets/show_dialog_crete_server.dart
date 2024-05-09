
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/validations/validation.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_list_bloc/server_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showDialogToCreateServer(
  {required BuildContext context,}
){
    showDialog(
            context: context,
             builder: (context) {
                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
              TextEditingController controller = TextEditingController();
               return Form(
                key:formKey ,
                 child: AlertDialog(
                   title:const Text("Create Server"),
                   content:kShowDialogTextField( 
                    validator: (value) {
                      return kServerNameValidation(value);
                    },  
                     statusController: controller, 
                      hintTxt: 'Server Name'       
                      ),
                   actions: [ 
                    Column( 
                      children: [
                        TextButton(onPressed: (){  
                          Navigator.pop(context);     
                        }, 
                         child:const Text("Cancel")),
                      ],
                    ),
                     BlocConsumer<ServerBloc, ServerState>(
                       listener: (context, state) {
                        if (state is CreateServerSuccessState) {
                          kSnakBar(context, "Server created", kClrLiteGreen);
                        }
                        if (state is CreateServerErrorState) {
                          kSnakBar(context, "Fail to create Server", kClrLiteRed);
                        }
                       },
                       builder: (context, state) { 
                         return TextButton( 
                            onPressed:()async{
                           if (formKey.currentState!.validate()&& controller.text.trim().isNotEmpty) {
                             context.read<ServerBloc>().add(CreateServerEvent(serverName:controller.text));
                              Navigator.pop(context);             
                            }
                           },
                           child:const Text("Create"));
                       },
                     ),
                 
                   ],
                 ),
               ); 
             },
             );
} 
