import 'package:crowd_verse/presentation/views/authentication/signup/bloc/bloc/signup_bloc.dart';
import 'package:crowd_verse/presentation/views/authentication/signup/widgets/email_verify.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/widgets/google_auth.wdget.dart';
import 'package:crowd_verse/presentation/widgets/textform_field_in_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/auth/user.dart';
import '../../../utils/core/color.dart';
import '../../../utils/validations/validation.dart';
import '../../../widgets/login_signup_button.dart';
import '../../../widgets/login_signuu_heding.dart';
import 'widgets/alredy_have_acc_widget.dart';

class ScreenSignup extends StatelessWidget {
   ScreenSignup({super.key});
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) { 
    TextEditingController userNameController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController eMailController = TextEditingController();
    TextEditingController passWordController = TextEditingController(); 
    return  Scaffold(
      body: SafeArea(  
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15), 
          child: SingleChildScrollView( 
            child: Form(
              key: _formKey,
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
               ////section1
               
              const LoginSignUpHedingWidget( 
                    title: 'Create Account',
                    text: 'Sign up to get started',
                   ),
              
               ////section2
                 
                const Text('UserName',style:TextStyle(color:kClrGrey),),  
                   BuildTextFormField(controller: userNameController,
                  hintTxt:'Enter UserName',  
                  prfixIcon: Icons.person_outlined, 
                  validator: (value) {
                    return Validator.validateNameAndUserName(value);
                  },
                  ),
                
                 kHeight20, 
                  
                  const Text('Name',style:TextStyle(color:kClrGrey),),  
                   BuildTextFormField( 
                    controller: nameController,
                  hintTxt:'Enter Name',
                  prfixIcon: Icons.person_outlined, 
                  validator: (value) {
                    return   Validator.validateNameAndUserName(value);
                  },
                  ),
                
                  kHeight20,
                  
                  const Text('Email',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                    validator:(value) {
                    return  Validator.validateEmail(value); 
                      
                    },
                    controller: eMailController,
                  hintTxt:'Enter Email', 
                  prfixIcon: Icons.email_outlined, 
                  ),
                
                  kHeight20,
                  
                  const Text('Password',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                  controller:passWordController ,
                  hintTxt:'Enter Password',  
                  prfixIcon: Icons.lock_outlined, 
                  validator: (value) {
                    return Validator.validatePassword(value); 
                  }, 
                  ),
                
                 kHeight50,
                
               ////section3   
         

  BlocConsumer<SignupBloc, SignupState>(
  listener: (context, state) {
    if (state is SignUpSuccessState) {
      kNavigationPushRemoveUntil(context, EmailverifyWidget(token:state.confirmToken ));
    } else if ( state is SignUpErroeState){
       kSnakBar(context, state.error, kClrLiteRed);
    }
  },


  builder: (context, state) {
    if (state is SignUpLoadingState) {
       return  Stack(
         children: [
          const LoginSignUpButtonWidget(
            text: 'Create Account',
            ),
          Center(child:  kCircularProgressIndicator)
         ],
       );
    }
  
    return LoginSignUpButtonWidget(
      text: 'Create Account', 
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          context.read<SignupBloc>().add(SignupEvent(
            user: UserModel( userName: userNameController.text, name: nameController.text,eMail: eMailController.text,password: passWordController.text,),
          ));
        }
      },
    );
  },
),
 
          
                
               kHeight20,  
 
                const GoogleAuthWidget(), 
 
                 kHeight20,
                    
                const AlredyHaveAccWidget()
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






