
import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/presentation/widgets/login_signuu_heding.dart';
import 'package:flutter/material.dart';
import '../../verifyOtp/widgets/otp_textform_widget.dart';
import 'reset_pass.dart';

class ScreenVerifyOtp extends StatelessWidget {
   ScreenVerifyOtp({super.key, required this.token});
   final String token;

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
                SizedBox(height: kHeight60,), 
                
                LoginSignUpButtonWidget(onPressed: (){ 
                 String otp="${cntrlr1.text}${cntrlr2.text}${cntrlr3.text}${cntrlr4.text}";
                if(_formKey.currentState!.validate()&&otp.length==4){
                   kNavigationPush(context, ScreenResetPassword(otp: otp,token: token,)); 
                }
                },
                 text: 'Next' 
                 ),
          
                 SizedBox(height: kHeight50,),
          
              ////////////////
                
               
            ],
          ),
        ),
      ),
    );
  }
}

