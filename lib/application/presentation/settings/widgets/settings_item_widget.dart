import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsItemWidget extends StatelessWidget {
   SettingsItemWidget({
    super.key,
     this.onTap,
    required this.icon,
    required this.title
  });
   void Function()? onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 10  ),
      padding:const EdgeInsets.symmetric(horizontal: 25 ),
      height: 60  , 
      width: double.infinity, 
      decoration: BoxDecoration(
       color: kClrWhite,
       borderRadius:BorderRadius.circular(10)  
      ),
      child:GestureDetector(
        onTap:onTap,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style:const TextStyle(fontSize: 20),), 
            Icon(icon,)
          ],
        ),
      ),
    );
  }
}