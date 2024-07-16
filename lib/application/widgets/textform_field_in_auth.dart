import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildTextFormField extends StatelessWidget {
    BuildTextFormField({
    super.key,
    required this.hintTxt,
      this.prfixIcon,
      this.controller,
      this.validator,
     this.obscureTxt=false
      
  });
  final String hintTxt;
   IconData? prfixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
   bool obscureTxt;
  @override
  Widget build(BuildContext context) { 
    return TextFormField(
      obscureText: obscureTxt,
      controller:controller ,
      validator: validator, 
      decoration: InputDecoration(
      border: InputBorder.none,
      fillColor: kClrLiteBlue,
      filled: true, 
      prefixIcon: Icon(prfixIcon,color: kClrBlue,),
      hintText:hintTxt ,  
      ),
    );
  }
}