import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTextField.dart';
import '../../../routes/app_pages.dart';
import '../controllers/regsiter_controller.dart';

class RegsiterView extends GetView<RegsiterController> {
  const RegsiterView({Key? key}) : super(key: key);
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

                      SizedBox(
                        height: 30.h,
                      ),

                      Image.asset('lib/assets/images/model2.png'),

                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: AutoSizeText(
                          'Please fill the information given below',
                          maxLines: 2,
                          minFontSize: 20,
                          maxFontSize: 25,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 25.sp
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Username',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 14,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          CustomTextField(
                            controller: controller.usernameController,
                            hinText: "Fasha",
                            obsureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input username';
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
                            'Email',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 14,
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
                        height: 40.h,
                      ),

                      SizedBox(
                        width: width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: ()=> controller.registerPost(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                          ),
                          child: Obx(() => controller.loadinglogin.value?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ): Text(
                            "Sign Up",
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
                        height: 15.h,
                      ),

                      textToRegister(),
                    ],
                  ),
                ),
              ),
            ),
          )),
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
              'Already have an account?',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: FittedBox(
              child: Text('Sign In',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
