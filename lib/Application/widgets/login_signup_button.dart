

import 'package:crowd_verse/Application/core/color.dart';
import 'package:flutter/material.dart';

class LoginSignUpButtonWidget extends StatelessWidget {
  const LoginSignUpButtonWidget({
    super.key,
    required this.onPressed, required this.text
  });
    final void Function()? onPressed;
    final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        decoration:const BoxDecoration(
        color: kClrBlue, 
        borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        height:45,
        child: Center(
          child: Text(text,style:const TextStyle(color: kClrWhite,fontSize: 16,fontWeight: FontWeight.bold),), 
        ),
      ),
      );
  }
}