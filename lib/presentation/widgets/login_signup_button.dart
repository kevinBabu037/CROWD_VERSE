

import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:flutter/material.dart';

class LoginSignUpButtonWidget extends StatelessWidget {
  const LoginSignUpButtonWidget({
    super.key,
     this.onPressed,
      required this.text,
      this.clr=kClrBlue,
      this.fontSize=16
  });
    final void Function()? onPressed;
    final String text;
    final Color? clr;
    final double fontSize;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
        color: clr, 
        borderRadius:const BorderRadius.all(Radius.circular(10))
        ), 
        height:45,
        child: Center(
          child: Text(text,style: TextStyle(color: kClrWhite,fontSize: fontSize,fontWeight: FontWeight.bold,),), 
        ),
      ),
      );
  }
}