import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PublicProfileShimmer extends StatelessWidget {
  const PublicProfileShimmer({ super. key,});
  
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white, 
      highlightColor: Colors.grey[300]!,     
      child: Column(
        children: [
          Container(height: 200,width: double.infinity,color:kClrWhite,),
          kHeight40,
          Container(height: 150,width: double.infinity,color:kClrWhite,),
           kHeight40,
           Container(height: 60,width: double.infinity,color:kClrWhite,),
        ],
      )
    ); 
  }
}
