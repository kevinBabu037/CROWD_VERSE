import 'package:crowd_verse/Application/core/functions.dart';
import 'package:crowd_verse/Application/core/height_width.dart';
import 'package:crowd_verse/Application/screens/Authentication/verifypassword/screen_verify_otp.dart';
import 'package:crowd_verse/Application/widgets/login_signup_button.dart';
import 'package:crowd_verse/Application/widgets/login_signuu_heding.dart';
import 'package:crowd_verse/Data/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../core/color.dart';
import '../signup/widgets/text_form.dart';

class ScreenForgotPassword extends StatelessWidget {
   ScreenForgotPassword({super.key});
   final eMailControler=TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 15), 
        child: Form(
          key:_formKey ,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const LoginSignUpHedingWidget(
                title: "What's your Email?", 
                 text: 'Conform Email'  
                 ),
          
                    const Text('Email',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                        controller:eMailControler,
                      hintTxt:'Enter Email', 
                      prfixIcon: Icons.email_outlined, 
                      ),
           
                      SizedBox(height: kHeight60,),  
                
          
                      LoginSignUpButtonWidget( 
                        onPressed: ()async{ 
                          if (_formKey.currentState!.validate()) {
                          String token= await SignUpService().resetPasswordConfirmMail(eMailControler.text);
                          if(token.isNotEmpty){
                            kNavigationPush(context, ScreenVerifyPassword(token: token,));
                          }
                          }
                          
                     
                        },
                         text: 'Next')
            ],
          ),
        ),
      ),
    );
  }
}