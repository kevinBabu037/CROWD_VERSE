import 'package:crowd_verse/Application/core/functions.dart';
import 'package:crowd_verse/Application/core/height_width.dart';

import 'package:crowd_verse/Application/widgets/login_signup_button.dart';
import 'package:crowd_verse/Data/Auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../core/color.dart';
import '../../../widgets/login_signuu_heding.dart';
import '../signup/widgets/text_form.dart';
import 'widgets/password_sucess_widget.dart';



class ScreenResetPassword extends StatelessWidget {
   ScreenResetPassword({super.key, required this.otp, required this.token});
   final String token;
  final String otp;
   final  passwordontroller=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15), 
        child: Form(
          key:_formKey ,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                 const LoginSignUpHedingWidget(
                    title: 'Reset Password',
                    text: 'Enter email address and a link to reset your password will be sent to you.',
                  ),
                    
                    const Text('Password',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                        validator: (value) {
                           if(value==null||value.isEmpty){
                            return "Enter new Passworrd";
                           } 
                           return null;
                        },
                        controller: passwordontroller,
                      hintTxt:'Reset Password', 
                      prfixIcon: Icons.lock_outlined,  
                      ),
                          
                        SizedBox(height: kHeight60,),
          
                      LoginSignUpButtonWidget(onPressed: (){
                        if(_formKey.currentState!.validate()){
                          SignUpService().resetPassword(passwordontroller.text, otp, token);
                          kNavigationPush(context,const PasswordSucessWidget());
                        }
                      
                      },
                       text: 'Continue') 
            ],
          ),
        ),
      ),
    );
  }
}