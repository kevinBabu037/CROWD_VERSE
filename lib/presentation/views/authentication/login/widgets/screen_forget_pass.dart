import 'package:crowd_verse/data/repositories/Auth/auth_service.dart';
import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/authentication/login/widgets/verify_otp.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/presentation/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/core/color.dart';
import '../../signup/widgets/text_form.dart';

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
                        controller:eMailControler,
                      hintTxt:'Enter Email', 
                      prfixIcon: Icons.email_outlined, 
                      ),
           
                      SizedBox(height: kHeight60,),  
                
          
                      LoginSignUpButtonWidget( 
                        onPressed: ()async{ 
                          if (_formKey.currentState!.validate()) {
                          final result= await AuthService().resetPasswordConfirmMail(eMailControler.text);
                          if(result.statusCode==201&&result.forgotPassToken!=null){
                            kNavigationPush(context, ScreenVerifyOtp(token: result.forgotPassToken!,));
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