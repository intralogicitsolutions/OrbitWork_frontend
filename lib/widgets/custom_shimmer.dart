import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  //final BorderRadius? borderRadius;
  // final Color baseColor;
  // final Color highlightColor;

  const CustomShimmer({
    Key? key,
    required this.width,
    required this.height,
    //this.borderRadius,
    // this.baseColor = const Color(0xFFE0E0E0),
    // this.highlightColor = const Color(0xFFF5F5F5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
         color: Colors.white,
          borderRadius:  BorderRadius.circular(4),
        ),
      ),
    );
  }
}
