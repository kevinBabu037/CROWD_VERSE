import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

editStatusDialog(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 
 
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
        builder: (context, state) {
          if (state is ProfileSuccessState) {
       TextEditingController statusController = TextEditingController(text:state.profile.statusTxt);
            return AlertDialog(
                    title:const Text('Edit Status'),
                    content: SingleChildScrollView(
                      child: Form(
                        key: formKey,  
                        child: Column(  
                          children: [  
                            const SizedBox(height: 16), 
                            kShowDialogTextField(
                              statusController: statusController,
                               hintTxt:'Add Status Message',
                               validator: (value)  {  
                                 if (value!.length > 60) {
                                   return "Please keep it within 60 characters.";
                                   }
                                 return null;
                               },  
                              ), 
                             
                            kHeight40,   
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ 
                            LoginSignUpButtonWidget( 
                              text: '   Cancel   ',
                              onPressed: () {  
                               Navigator.pop(context);
                              }, 
                            ),  
                            LoginSignUpButtonWidget(
                              text:"   Add   ",  
                              onPressed: () { 
                                if (formKey.currentState!.validate()) {
                                  context.read<ProfileDetailsBloc>().add(AddStatusEvent(txt:statusController.text));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          } 
          return const Center(child: Text('Somthing went wrong'),);
        },
      );
      
    },
  );
}

