import 'package:get/get.dart';

import '../../onboarding/controllers/onboarding_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Inisialisasi dan panggil OnboardingController
    OnboardingController onboardingController = Get.put(OnboardingController());

    // Tunggu sebentar (misalnya, 2 detik) di SplashScreen sebelum pindah ke halaman selanjutnya
    Future.delayed(const Duration(seconds: 3), () {
      // Pindah ke halaman berikutnya (dikelola oleh OnboardingController)
      onboardingController.goToNextPage();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
