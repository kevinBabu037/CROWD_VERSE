
import 'package:crowd_verse/utils/core/color.dart';
import 'package:flutter/material.dart';

kNavigationPush(BuildContext context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushReplacement(BuildContext context,Widget screen){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushRemoveUntil(BuildContext context,Widget screen){
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>screen,), (route) => false);
}


kSnakBar(BuildContext context,String content,Color clr){
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:kClrWhite ,
              content:Container(
                decoration:BoxDecoration(
                  color: clr, 
                  borderRadius:BorderRadius.circular(5) 
                   ) ,
                height: 40,
                width:double.infinity ,
                child: Center(child: Text(content,style:const TextStyle(fontWeight: FontWeight.bold),)),
              )
            ),
          );
}

kSnakBarToDisplayError(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text),
         const CircularProgressIndicator()
        ],
      )
      )
  );
}