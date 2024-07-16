import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFriendsListTile extends StatelessWidget {
  const ShimmerFriendsListTile({ super. key,});
  
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors( 
      baseColor: Colors.white, 
      highlightColor: Colors.grey[300]!,     
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return  ListTile( 
            title: Container(  
              color: kClrBlue,   
              height: 30,
              width: double.infinity,   
            ),  
            leading:const CircleAvatar(  
              radius: 30,  
            ),   
          );
        }, 
        )
    ); 
  }
}
 