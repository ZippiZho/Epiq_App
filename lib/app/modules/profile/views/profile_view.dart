import 'package:epiq_fasha/app/data/provider/storage_provider.dart';
import 'package:epiq_fasha/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: Scaffold(
          body: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),

                Stack(
                  children: [
                    // Profile Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'lib/assets/images/profile.png',
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.w,
                      ),
                    ),
                    // Button Overlay
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle button tap (e.g., open image picker)
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F5F5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15.h,
                ),

                sectionDataUser(),

                SizedBox(
                  height: 30.h,
                ),

                sectionMenuProfile(),

                SizedBox(
                  height: 10.h,
                ),

                sectionMenuProfile2(),
              ],
            ),
          )
      ),
    );
  }

  Widget sectionDataUser(){
    String usernameUser = StorageProvider.read(StorageKey.username);
    String emailUser = StorageProvider.read(StorageKey.email);
    String teleponUser = StorageProvider.read(StorageKey.telepon);

    return Column(
      children: [
        Text(
          usernameUser,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),

        SizedBox(
          height: 3.h,
        ),

        Text(
          '$emailUser|$teleponUser',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget sectionMenuProfile(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.UPDATEPROFILE);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/icon_formulir.svg',
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Edit profile information",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Notification",
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() =>
                          SizedBox(
                            height: 28.w,
                            child: Switch(
                              value: controller.isSwitched.value,
                              activeColor: Colors.white,
                              onChanged: (bool value) {
                                controller.toggleSwitch();
                              },
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Language",
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() =>
                          SizedBox(
                            height: 28.w,
                            child: Switch(
                              value: controller.isSwitched.value,
                              activeColor: Colors.white,
                              onChanged: (bool value) {
                                controller.toggleSwitch();
                              },
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionMenuProfile2(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.UPDATEPROFILE);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/icon_formulir.svg',
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Help & Support",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/icon_formulir.svg',
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Contact Us",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Logout",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
