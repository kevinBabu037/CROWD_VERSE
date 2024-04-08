
import 'package:crowd_verse/utils/core/color.dart';
import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/profile/widgets/settings_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/about_me_widget.dart';
import 'widgets/firends_widget.dart';
import 'widgets/profile_details_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});
 
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size; 

    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 241, 236, 236), 
     body: SingleChildScrollView( 
       child: Stack(
         children: [
           Column(
             children: [
             Container(
              color: Colors.amber,
              width: double.infinity,
               height:screenSize.height*0.2,
               child: Image.network('https://i.pinimg.com/736x/fb/78/c7/fb78c7581af78ca1827e63772c9c6569.jpg',fit: BoxFit.cover,), 
             ),
       
             SizedBox(height:screenSize.height*0.1-25,),    
             ProfileDetailsWidget(screenSize: screenSize) ,
             SizedBox(height: kHeight20,),
       
             AboutMeWidget(screenSize: screenSize),
             SizedBox(height: kHeight20,),
       
             FriendsWidget(screenSize: screenSize)
        
             
             ], 
           ),
            Positioned(
              left: 30 ,
                top: screenSize.height*0.1+28,
                child:const CircleAvatar( 
                   backgroundColor:kClrWhite ,
                  radius: 50,
                  child:CircleAvatar(
                   radius: 45 , 
                   backgroundImage: NetworkImage('https://i.pinimg.com/564x/11/53/bb/1153bb5e641cdc3dde7002ae68527c94.jpg'),
                  ) ,
                ),
              ),
              Positioned(
                top: 30 ,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    kNavigationPush(context,const ScreenSettings());
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: kClrBlack.withOpacity(0.5),
                    child:const Icon(Icons.settings,color:kClrWhite,),
                  ),
                ),
              ) 
         ],
       ),
     ),
   
    );
  }
}






