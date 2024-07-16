import 'package:crowd_verse/application/utils/core/text.dart';
import 'package:crowd_verse/application/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Privacy Poliicy",
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pop(context);
        },
        ),
      body: ListView(
        padding:const EdgeInsets.all(10),
        children: [
          Text(privacyPolicyTxt,style:const TextStyle(fontSize: 16),)
        ],
      ) 
    );
  }
}

