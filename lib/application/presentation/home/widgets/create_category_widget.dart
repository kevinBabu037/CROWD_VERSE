
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/validations/validation.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/category_bloc/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showDialogToCreateCategory(
  {required BuildContext context,
   required String serverID
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
                   title:const Text("Create Category"),
                   content:kShowDialogTextField( 
                    validator: (value) {
                      return kServerNameValidation(value);  
                    },  
                     statusController: controller, 
                      hintTxt: 'Category name'        
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
                             context.read<CategoryBloc>().add(CreateCategoryEvent(serverID: serverID, categoryName:controller.text));
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
