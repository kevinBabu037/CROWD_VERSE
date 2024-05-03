
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/views/home/widgets/channel_and_details.dart';
import 'package:crowd_verse/presentation/views/home/widgets/server_list_widget.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override 
  Widget build(BuildContext context) { 
    ServerService().getAllService(); 
    Size screenSize = MediaQuery.of(context).size; 
    return  Scaffold(
       backgroundColor:kClrProfileScafold ,
     body: Row(
      children: [
        ServerListWidget(screenSize: screenSize), 

        ChannelsAndDetailsWidget(screenSize: screenSize,)
      ],
     ),
     
    ); 
  }
}


 