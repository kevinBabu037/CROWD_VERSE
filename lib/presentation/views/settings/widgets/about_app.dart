import 'package:crowd_verse/presentation/utils/core/text.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: CustomAppBar(
        title: "About",
        icon: Icons.arrow_back, 
        onPressed: () {
          Navigator.pop(context);
        },
        ),
      body: ListView( 
        padding:const EdgeInsets.all(10),
        children: [
          Text(abouMyApptxt,style:const TextStyle(fontSize: 16),)
        ],
      ) 
    );
  }
}