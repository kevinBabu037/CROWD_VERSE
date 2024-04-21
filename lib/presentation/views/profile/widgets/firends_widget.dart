import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:flutter/material.dart';

import '../../../utils/core/color.dart';

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
     padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10 ,right: 10 ), 
           height: screenSize.height*0.1-25 ,
           width: screenSize.width-35,
           decoration:  BoxDecoration(
           borderRadius: BorderRadius.circular(10 ),
          color:kClrWhite,
          ),
          child: Stack( 
            children: [
             const Row(
                children: [  
                  Text('Your Friends',style: TextStyle(fontSize: 20),),
                  Spacer(),
                  CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pinimg.com/564x/66/fd/3f/66fd3fb8b00a53560dcb7d888e206006.jpg'),
                 radius: 10.2,
                  ),
                  
                  SizedBox(width: 40,),
                   Icon(Icons.arrow_forward_ios,size: 18,) 
                ],
              ),
               Positioned(
                 right: 40 ,
                 child: CircleAvatar(
                  backgroundColor: kClrWhite,
                      radius: 13, 
                      child: CircleAvatar(
                        radius: 10,
                       backgroundImage:AssetImage(kAppLogo) ,
                      ),
                      ),
               ),
              
            ],
          ),
    );
  }
}
