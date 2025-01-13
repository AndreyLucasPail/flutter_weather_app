import 'package:flutter/material.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAnimation extends StatelessWidget {
  const ShimmerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: CustomColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            shimmerContainer(40, 300),
            const SizedBox(height: 20),
            shimmerContainer(40, 300),
            const SizedBox(height: 20),
            shimmerContainer(40, 300),
            const SizedBox(height: 20),
            shimmerContainer(40, 300),
          ],
        ),
      ),
    );
  }

  Widget shimmerContainer(double height, double width) {
    return Shimmer.fromColors(
      baseColor: CustomColors.white,
      highlightColor: CustomColors.blue,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
