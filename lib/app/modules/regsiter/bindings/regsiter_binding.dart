import 'package:get/get.dart';

import '../controllers/regsiter_controller.dart';

class RegsiterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegsiterController>(
      () => RegsiterController(),
    );
  }
}
