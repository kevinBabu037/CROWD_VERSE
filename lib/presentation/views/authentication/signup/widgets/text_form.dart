import 'package:crowd_verse/utils/core/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildTextFormField extends StatelessWidget {
   BuildTextFormField({
    super.key,
    required this.hintTxt,
     required this.prfixIcon,
      this.controller,
      this.validator,
     
      
  });
  final String hintTxt;
  final IconData prfixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  
  @override
  Widget build(BuildContext context) { 
    return TextFormField(
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