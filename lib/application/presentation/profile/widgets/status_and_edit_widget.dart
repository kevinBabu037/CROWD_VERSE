
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:flutter/material.dart';

class StatusAndEditWidget extends StatelessWidget {
  const StatusAndEditWidget({
    super.key,
    required this.screenSize, 
    required this.icon, 
     required this.text,
  });
  final IconData icon;
  final Size screenSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 10 ,right: 10),
      height: 36, 
      width: screenSize.width*0.4, 
      decoration: BoxDecoration( 
        color: kClrBlue,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center( 
        child: Row(
          children: [
            Icon(icon,color: kClrWhite,), 
           const SizedBox(width: 10,), 
            Text(text,style:const TextStyle(color: kClrWhite,fontSize: 15,fontWeight: FontWeight.bold),)
          ],
        ),
      ) ,
    );
  }
}