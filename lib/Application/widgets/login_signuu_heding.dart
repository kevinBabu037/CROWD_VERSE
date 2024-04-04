


import 'package:flutter/material.dart';

import '../core/height_width.dart';
import '../core/style.dart';

class LoginSignUpHedingWidget extends StatelessWidget {
 const  LoginSignUpHedingWidget({
    super.key,
     required this.title, 
     required this.text,
     this.hightFromTop=50
  });
  final String title;
  final String text;
  final double hightFromTop;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
    SizedBox(height:hightFromTop),
     Text(title,style:kLoginSingnupHeding), 
    SizedBox(height: kHeight10,), 
     Text(text,),
    SizedBox(height: kHeight30,),
      ],
    );
  }
}