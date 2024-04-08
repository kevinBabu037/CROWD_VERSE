import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import '../../../../../data/repositories/Auth/auth_service.dart';
import '../../../../../utils/core/color.dart';
import '../../../../../utils/validations/validation.dart';
import '../../../../widgets/login_signuu_heding.dart';
import '../../signup/widgets/text_form.dart';
import 'password_sucess_widget.dart';



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
                           return Validator.validatePassword(value);
                        },
                        controller: passwordontroller,
                      hintTxt:'Reset Password', 
                      prfixIcon: Icons.lock_outlined,  
                      ),
                          
                        SizedBox(height: kHeight60,),
          
                      LoginSignUpButtonWidget(onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                        final result= await AuthService().resetPassword(passwordontroller.text, otp, token);
                         if(result){
                          kNavigationPush(context,const PasswordSucessWidget());
                         }else{
                          kSnakBar(context, 'Somthing rong in OTP verification try again later', kClrLiteRed);
                         }
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