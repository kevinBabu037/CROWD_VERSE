import 'package:crowd_verse/data/models/profile/public_profile_model.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:flutter/material.dart';

class PublicUserAboutDetailsWidget extends StatelessWidget {
  const PublicUserAboutDetailsWidget({
    super.key,
    required this.screenSize,
     required this.model,
  });
   final PublicProfileModel model;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
  String date = kDateTimeConverter(model.joinDate!);
    return Container(
      padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10),   
      width:screenSize.width-35,   
      decoration: BoxDecoration(
        color: kClrWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column( 
         mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         model.aboutTxt!=null?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
             const Text(
                    'About Me',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ), 
                  Text( 
                    model.aboutTxt!,
                    style:const TextStyle(fontSize: 18),
                  ),
            ],
          ):const SizedBox(),
         
                   
        const Text(
              'Croud Verse Member Since', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), 
            Text(
      date,
      style:const  TextStyle(fontSize: 18), 
    ),
        ],
      ) ,
    );
  }
}