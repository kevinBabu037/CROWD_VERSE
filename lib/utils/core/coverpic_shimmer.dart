import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCoverPicLoading extends StatelessWidget {
  const ShimmerCoverPicLoading({ super. key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white, 
      highlightColor: Colors.grey[300]!,   
      child: Container(
        height: height,  
        width: double.infinity,  
        color: Colors.white, 
             
      ),
    ); 
  }
}
 