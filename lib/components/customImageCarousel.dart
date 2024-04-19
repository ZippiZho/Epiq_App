import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageCarousel extends StatelessWidget {
  const CustomImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: const Color(0xFF41B54A),
        indicatorBackgroundColor: Colors.grey,
        onPageChanged: (value) {
        },
        autoPlayInterval: 15000,
        isLoop: true,
        children: [
          Image.asset(
            'lib/assets/slider/slider1.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'lib/assets/slider/slider3.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'lib/assets/slider/slider4.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
