import 'package:crowd_verse/application/presentation/authentication/login/bloc/bloc/login_bloc.dart';
import 'package:crowd_verse/application/widgets/login_signup_button.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/widgets/textform_field_in_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/core/color.dart';
import '../../../../utils/validations/validation.dart';
import '../../../../widgets/login_signuu_heding.dart';
import 'password_sucess_widget.dart';



class ScreenResetPassword extends StatelessWidget {
  ScreenResetPassword({
    super.key, required this.otp,
     });
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
                           return Validator.validatePassword(value);
                        },
                        controller: passwordontroller,
                      hintTxt:'Reset Password', 
                      prfixIcon: Icons.lock_outlined,  
                      ),
                          
                        kHeight60,

                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                         if (state is ResetPasswordSuccessState) {
                           kNavigationPushReplacement(context,const PasswordSucessWidget());
                           
                         }
                         else if(state is ResetPasswordErrorState){
                          kSnakBar(context, state.error, kClrLiteRed);
                         }
                        },
                        builder: (context, state) {
                          return LoginSignUpButtonWidget(
                            text: 'Continue',
                             onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                 context.read<LoginBloc>().add(ResetPassEvent(otp: otp, newPassword: passwordontroller.text));
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