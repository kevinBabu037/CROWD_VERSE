
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/widgets/login_signup_button.dart';
import 'package:crowd_verse/application/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';
import 'otp_textform_widget.dart';
import 'reset_pass.dart';

class ScreenVerifyOtp extends StatelessWidget {
   ScreenVerifyOtp({
    super.key, 
    // required this.token
    });
  //  final String token;

  final  cntrlr1=TextEditingController();
  final  cntrlr2=TextEditingController();
  final  cntrlr3=TextEditingController();
  final  cntrlr4=TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding:const  EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
             const LoginSignUpHedingWidget(
              
                title: 'Verify OTP',
                 text: 'Please enter the code we sent you to email'
                 ),
               
                Form(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    OtpTextFormFieldWidget(
                    controller: cntrlr1,            
                    ),
                    OtpTextFormFieldWidget(
                    controller: cntrlr2,
                    ),
                    OtpTextFormFieldWidget(
                    controller: cntrlr3,
                    ),
                    OtpTextFormFieldWidget(
                    controller: cntrlr4,
                    ),
                    
                  ],
                )),
                kHeight60,
                
                LoginSignUpButtonWidget(onPressed: (){ 
                 String otp="${cntrlr1.text}${cntrlr2.text}${cntrlr3.text}${cntrlr4.text}";
                if(_formKey.currentState!.validate()&&otp.length==4){
                   kNavigationPush(context, ScreenResetPassword(otp: otp,)); 
                }else{
                  kSnakBar(context,'Enter 4 digit otp to Proceed',kClrLiteRed); 
                }
                
                },
                 text: 'Next' 
                 ),
          
                kHeight50
          
              ////////////////
                
               
            ],
          ),
        ),
      ),
    );
  }
}

