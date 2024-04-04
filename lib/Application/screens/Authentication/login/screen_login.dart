import 'package:crowd_verse/Application/core/functions.dart';
import 'package:crowd_verse/Application/core/height_width.dart';
import 'package:crowd_verse/Application/screens/Authentication/signup/screen_signup.dart';
import 'package:crowd_verse/Application/screens/nav_bar/nav_bar.dart';
import 'package:crowd_verse/Application/widgets/login_signup_button.dart';
import 'package:crowd_verse/Application/widgets/login_signuu_heding.dart';
import 'package:crowd_verse/Data/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../core/color.dart';
import '../forgot_pass/screen_forget_pass.dart';
import '../signup/widgets/text_form.dart';

class ScreenLogIn extends StatelessWidget {
  const ScreenLogIn({super.key});
   
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController eMailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15), 
        child: SingleChildScrollView(
          child: Form(
            key:formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
               const LoginSignUpHedingWidget(
                  title: 'Login',
                  text: 'Login to get started',
                ),
            
                 /////////////
                 
                    const Text('Email',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                      hintTxt:'Enter Email', 
                      prfixIcon: Icons.email_outlined, 
                      controller:eMailController ,
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return "Required";
                        }
                        return null;
                      },
                      ),
             
                        SizedBox(height: kHeight10,),
                      Align(alignment: Alignment.centerRight,  
                     child:  GestureDetector(
                      onTap: () {
                        kNavigationPush(context, ScreenForgotPassword());
                      },
                      child:const Text('Forgot Password?'))),
                     SizedBox(height: kHeight20,),
                  
                    const Text('Password',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                      hintTxt:'Enter Password', 
                      prfixIcon: Icons.lock_outlined, 
                      controller:passwordController ,
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return "Required";
                        }
                        return null;
                      },
                      ),
                     
                  //////////////////
            
                       SizedBox(height: kHeight60,),   
            
                     LoginSignUpButtonWidget( 
                      text: 'Login',  
                      onPressed: ()async{
                      if (formKey.currentState!.validate()) { 
                      final isUser = await SignUpService().userLogin(eMailController.text, passwordController.text);
                        if( isUser){
                          kNavigationPushReplacement(context, ScreenNavBar());
                           kSnakBar(context, 'Login Sucessfull',kClrLiteGreen);
                        }else{
                          kSnakBar(context," Email & Password don't match",kClrLiteRed);
                        }
                      }
                      } 
                      ),
            
                      SizedBox(height: kHeight30,),
            
                  Align(child: GestureDetector( 
                    onTap: () {
                      kNavigationPushReplacement(context, ScreenSignup()); 
                      }, 
                    child:const Text('Create Account',style: TextStyle(color: kClrBlue),)
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
