


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextFormFieldWidget extends StatelessWidget {
  const OtpTextFormFieldWidget({
    super.key, required this.controller,
  });
   final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      height: 68, 
      width: 65, 
      child: TextFormField(
        controller:controller ,
        validator: (value) {
          if(value==null ||value.isEmpty){
            return "";
          }
          return null;
        },
        style:const TextStyle(fontSize: 30), 
        keyboardType: TextInputType.number, 
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if(value.length==1){
          FocusScope.of(context).nextFocus();
          }
          if(value.isEmpty){
          FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}