import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:epiq_fasha/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    const Color primary = Color(0xFF41B54A);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) => Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          'lib/assets/images/model1.png',
                        height: height * 0.30,
                      ),

                      SizedBox(
                        height: height * 0.005,
                      ),

                      FittedBox(
                        child: AutoSizeText(
                          'Welcome To',
                          maxLines: 1,
                          minFontSize: 40,
                          maxFontSize: 45,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 45.sp),
                        ),
                      ),

                      FittedBox(
                        child: AutoSizeText(
                          'EpiQ!',
                          maxLines: 1,
                          minFontSize: 45,
                          maxFontSize: 50,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              color: primary,
                              fontSize: 50.sp),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.030,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Email',
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          CustomTextField(
                            controller: controller.emailController,
                            hinText: "fasha@smk.belajar.id",
                            obsureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input email address';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Email address tidak sesuai';
                              } else if (!value.endsWith('@smk.belajar.id')) {
                                return 'Email harus @smk.belajar.id';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Password',
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          Obx(
                                () => CustomTextField(
                              controller: controller.passwordController,
                              hinText: "password",
                              obsureText: controller.isPasswordHidden.value,
                              suffixIcon: InkWell(
                                child: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: primary,
                                ),
                                onTap: () {
                                  controller.isPasswordHidden.value =
                                  !controller.isPasswordHidden.value;
                                },
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pleasse input password';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: height * 0.050,
                      ),

                      SizedBox(
                        width: width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: ()=> controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                          ),
                          child: Obx(() => controller.loadinglogin.value?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ): Text(
                            "Continue",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                          ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.015,
                      ),

                      textToRegister(),

                      SizedBox(
                        height: height * 0.020,
                      ),

                      textOrSignIn(),

                      SizedBox(
                        height: height * 0.020,
                      ),

                      Center(
                        child: Image.asset(
                          'lib/assets/images/google.png',
                          width: 35.w,
                          height: 35.w,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget textToRegister() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'Dont have an account?',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.REGSITER);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: FittedBox(
              child: Text('Sign Up',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF000000),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget textOrSignIn() {
    return const SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: Color(0xFFA8A8A8),
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or',
              style: TextStyle(
                color: Color(0xFFA8A8A8),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color(0xFFA8A8A8),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
