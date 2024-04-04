import 'package:crowd_verse/Application/core/functions.dart';
import 'package:crowd_verse/Application/core/height_width.dart';
import 'package:crowd_verse/Application/screens/Authentication/Email_verify/email_verify.dart';
import 'package:crowd_verse/Application/screens/Authentication/signup/widgets/google_auth.wdget.dart';
import 'package:crowd_verse/Data/Auth/auth_service.dart';
import 'package:crowd_verse/Data/models/user.dart';
import 'package:flutter/material.dart';
import '../../../core/color.dart';
import '../../../widgets/login_signup_button.dart';
import '../../../widgets/login_signuu_heding.dart';
import 'widgets/alredy_have_acc_widget.dart';
import 'widgets/text_form.dart';

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
                    if(value==null || value.isEmpty){
                      return 'required';
                    } 
                    return null;
                  },
                  ),
                
                 SizedBox(height: kHeight20,), 
                  
                  const Text('Name',style:TextStyle(color:kClrGrey),),  
                   BuildTextFormField( 
                    controller: nameController,
                  hintTxt:'Enter Name',
                  prfixIcon: Icons.person_outlined, 
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'required';
                    } 
                    return null;
                  },
                  ),
                
                  SizedBox(height: kHeight20,),
                  
                  const Text('Email',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                    validator: (value) { 
                      if (value==null || value.isEmpty) {
                        return "enter valid EMail"; 
                      } 
                      return null;
                    },
                    controller: eMailController,
                  hintTxt:'Enter Email', 
                  prfixIcon: Icons.email_outlined, 
                  ),
                
                  SizedBox(height: kHeight20,),
                  
                  const Text('Password',style:TextStyle(color:kClrGrey),),   
                   BuildTextFormField( 
                    controller:passWordController ,
                  hintTxt:'Enter Password', 
                  prfixIcon: Icons.lock_outlined, 
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'required';
                    } 
                    return null;
                  }, 
                  ),
                
                  SizedBox(height: kHeight50,) ,
                
               ////section3 
                
                LoginSignUpButtonWidget(
                  text:'Create Account' ,
                  onPressed: ()async {
                    if(_formKey.currentState!.validate()){
                String token=  await SignUpService().createUser(
                        UserModel(userName:userNameController.text , name: nameController.text, eMail:eMailController.text, password:passWordController.text),
                      );
                      if(token.isNotEmpty){
                         kNavigationPush(context, EmailverifyWidget(token:token,));
                      }
                      
                    } 
               },), 
               
               SizedBox(height: kHeight20,), 

                const GoogleAuthWidget(), 

                 SizedBox(height: kHeight20,),
                    
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






