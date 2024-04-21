import 'package:crowd_verse/presentation/views/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:crowd_verse/presentation/widgets/google_auth.wdget.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/authentication/signup/screen_signup.dart';
import 'package:crowd_verse/presentation/views/nav_bar/nav_bar.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/presentation/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/core/color.dart';
import '../../../utils/validations/validation.dart';
import '../signup/widgets/text_form.dart';
import 'widgets/forget_pass.dart';

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
                        return Validator.validateEmail(value);
                      },
                      ),
             
                        kHeight10,
                      Align(alignment: Alignment.centerRight,  
                     child:  GestureDetector(
                      onTap: () {
                        kNavigationPush(context, ScreenForgotPassword());
                      },
                      child:const Text('Forgot Password?'))),
                     kHeight20,
                  
                    const Text('Password',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                       obscureTxt: true, 
                      hintTxt:'Enter Password',  
                      prfixIcon: Icons.lock_outlined, 
                      controller:passwordController ,
                      validator: (value) {
                        return Validator.validatePassword(value);
                      },
                      ),
                     
                  //////////////////
            
                        kHeight60, 
            

                     BlocConsumer<LoginBloc, LoginState>( 
                      listener: (context, state) {
                        if (state is LoginErrorState) {
                          kSnakBar(context,"Email & Password don't match",kClrLiteRed);
                        }else if(state is LoginSuccessState){
                          kNavigationPushRemoveUntil(context,const ScreenNavBar());
                        }
                      },
                      builder: (context, state) {                     
                        return  LoginSignUpButtonWidget( 
                      text: 'Login',  
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                         context.read<LoginBloc>().add(LoginAction(password: passwordController.text, email: eMailController.text));
                        }
                      }
                      );
                      },
                     ),
             
                     kHeight20,

                     const GoogleAuthWidget(),

                      kHeight20,
            
                  Align(child: GestureDetector(  
                    onTap: () {
                      kNavigationPushReplacement(context, ScreenSignup()); 
                      }, 
                    child:const Text('Create Account',style: TextStyle(color: kClrBlue,fontSize: 16,fontWeight: FontWeight.bold),)
                    )),
              ],
            ),
          ), 
        ),
      ),
    );
  }
}
