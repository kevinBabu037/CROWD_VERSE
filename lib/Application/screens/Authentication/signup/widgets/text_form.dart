import 'package:flutter/material.dart';
import '../../../../core/color.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.hintTxt,
     required this.prfixIcon,
      this.controller,
      this.validator
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