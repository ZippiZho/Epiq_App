import 'package:auto_size_text/auto_size_text.dart';
import 'package:epiq_fasha/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const Color primary = Color(0xFF41B54A);
    return Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'lib/assets/images/bg_onboarding.png',
                ),
                fit: BoxFit.cover,
              )
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AutoSizeText(
                  'Open a Book Open Your World.',
                  maxLines: 3,
                  minFontSize: 40,
                  maxFontSize: 50,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: width * 0.80,
                  child: AutoSizeText(
                    'Dive into Stories',
                    maxLines: 1,
                    minFontSize: 20,
                    maxFontSize: 23,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),

                SizedBox(
                  width: width * 0.80,
                  child: AutoSizeText(
                    'Start Reading Now',
                    maxLines: 1,
                    minFontSize: 20,
                    maxFontSize: 23,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ()=> Get.offAllNamed(Routes.LOGIN),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
