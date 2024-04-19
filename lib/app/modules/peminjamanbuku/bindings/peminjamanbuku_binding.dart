import 'package:get/get.dart';

import '../controllers/peminjamanbuku_controller.dart';

class PeminjamanbukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeminjamanbukuController>(
      () => PeminjamanbukuController(),
    );
  }
}
