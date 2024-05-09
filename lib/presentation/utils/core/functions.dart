
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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



kShowDialog(
  {
  required BuildContext context,
  required String title,
  required String contentTxt,
  required String actionBtn1Txt,
  required String actionBtn2Txt,
  required void Function()? onPressed
  }
){
    showDialog(
            context: context,
             builder: (context) {
               return AlertDialog(
                 title: Text(title),
                 content: Text(contentTxt),
                 actions: [
                  TextButton(onPressed: (){
                   Navigator.pop(context);
                  },
                   child: Text(actionBtn1Txt)),
                   TextButton(
                    onPressed:onPressed,
                   child: Text(actionBtn2Txt)),

                 ],
               );
             },
             );
} 



String kDateTimeConverter(String date) {
  try {
    DateTime joinDate = DateTime.parse(date.split(' ')[0]);
    
    String formattedDate = DateFormat.yMMMMd().format(joinDate);
    
    return formattedDate;
  } catch (e) {
    return 'Invalid Date';
  }
}


String kMessageTimeConverter(String dateString) {
  try {
    List<String> parts = dateString.split(' ');

    String timePart = parts[1];

    List<String> timeParts = timePart.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    String period = (hour < 12) ? 'AM' : 'PM';

    if (hour > 12) {
      hour = hour - 12;
    } else if (hour == 0) {
      hour = 12; 
    } 

    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  } catch (e) {
    return ''; 
  }
} 


String kdateConverter(String dateString) {
  try {
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(dateString);
    String formattedDate = DateFormat.yMd().format(dateTime);
    return formattedDate;
  } catch (e) {
    return 'error';
  }
}


TextFormField kShowDialogTextField({
  required TextEditingController statusController,
   required String hintTxt,
   String? Function(String?)? validator
  }) {
  return TextFormField(
        controller: statusController, 
        validator: validator,
        maxLines: 2,  
        decoration:  InputDecoration( 
          hintText: hintTxt, 
          border:const OutlineInputBorder(),
        ),
       );
}


String kServerNameFormter(String serverName) {
  List<String> words = serverName.split(' ');
  if (words.length >= 2) {
    return words[0][0].toUpperCase()+words[1][0];
  } else {
    return serverName[0].toUpperCase()+serverName[1];
  }
}

