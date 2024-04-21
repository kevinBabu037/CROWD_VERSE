import 'package:crowd_verse/presentation/views/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/widgets/login_signuu_heding.dart';
import 'package:crowd_verse/presentation/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/core/color.dart';
import '../../../../utils/core/functions.dart';
import '../../signup/widgets/text_form.dart';
import 'verify_otp.dart';

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
                 text: 'Confirm Email'   
                 ),
          
                    const Text('Email',style:TextStyle(color:kClrGrey),),   
                       BuildTextFormField( 
                        validator: (value) {
                          return Validator.validateEmail(value); 
                        },
                        controller:eMailControler,
                      hintTxt:'Enter Email', 
                      prfixIcon: Icons.email_outlined, 
                      ),
           
                      kHeight60,
             
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if(state is ForgotPassMailsuccessState){
                             kNavigationPush(context, ScreenVerifyOtp());
                          }
                          else if (state is ForgotPassMailErrorState) {
                            kSnakBar(context, state.error, kClrLiteRed); 
                          }
                        },
                        builder: (context, state) {
                          if (state is  ForgotPassMailLoadingState) { 
                         return  const Stack(
                              children: [
                                LoginSignUpButtonWidget(
                                text: 'Next',
                                ),
                                Center(child: CircularProgressIndicator(),)
                              ],
                            );
                          }
                          return LoginSignUpButtonWidget( 
                            text: 'Next',
                            onPressed: () { 
                              if (_formKey.currentState!.validate()) { 
                               context.read<LoginBloc>().add(ForgotPassMailVerificationEvent(email: eMailControler.text));

                              }
                            },
                            );
                        },
                      )
            ],
          ),
        ),
      ),
    );
  }
}