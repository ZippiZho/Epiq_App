import 'package:epiq_fasha/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    // Color
    const Color colorPrimary = Color(0xFF41B54A);

    // Berpindah halaman
    Future.delayed(
      const Duration(milliseconds: 4000),((){
        Get.offAllNamed(Routes.ONBOARDING);
    })
    );
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: colorPrimary,
        child: Center(
          child: SvgPicture.asset(
            'lib/assets/logo/logo_white.svg',
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
