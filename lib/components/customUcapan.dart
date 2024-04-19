import 'package:auto_size_text/auto_size_text.dart';
import 'package:epiq_fasha/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUcapan extends StatelessWidget {
  const CustomUcapan({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const Color primary = Color(0xFF41B54A);

    void navigateToDashboard() {
      Future.delayed(Duration(seconds: 5), () {
        Get.offAllNamed(Routes.DASHBOARD);
      });
    }

    navigateToDashboard();

    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                  'lib/assets/images/model3.png',
                width: 300,
                height: 300,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: width * 0.70,
                child: AutoSizeText(
                  "You’re ready to go!",
                  maxLines: 2,
                  minFontSize: 30,
                  maxFontSize: 45,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AutoSizeText(
                'Read More, Paperless. Open Minds, Boundless Discoveries.',
                maxLines: 2,
                minFontSize: 15,
                maxFontSize: 18,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
