import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {

  final box = GetStorage();
  final String _onboardingKey = 'onboardingShown';

  @override
  void onInit() {
    super.onInit();
    if (box.read<bool>(_onboardingKey) == null) {
      // Jika belum, maka tampilkan halaman onboarding
      showOnboarding();
    } else {
      // Jika sudah, arahkan ke halaman berikutnya (misalnya, login)
      goToNextPage();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showOnboarding() {
    // Tampilkan halaman onboarding
    // Setelah selesai, simpan informasi bahwa onboarding sudah ditampilkan
    box.write(_onboardingKey, true);

    // Lanjutkan ke halaman berikutnya (misalnya, login)
    goToNextPage();
  }

  void goToNextPage() {
    // Navigasi ke halaman selanjutnya (misalnya, login)
    Get.offNamed(Routes.LOGIN);
  }
}
