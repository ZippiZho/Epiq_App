import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: Obx(
            () {
          final SliderController sliderController = Get.find<SliderController>();
          return PageView.builder(
            controller: sliderController.pageController,
            itemCount: sliderController.images.length,
            onPageChanged: (index) {
              sliderController.selectedIndex.value = index;
            },
            itemBuilder: (context, index) {
              return Container(
                child: Image.asset(
                  sliderController.images[index].imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SliderController extends GetxController {
  var selectedIndex = 0.obs;
  late final PageController pageController;

  final List<ImageModel> images = [
    ImageModel('lib/assets/slider/slider1.png'),
    ImageModel('lib/assets/slider/slider2.png'),
    ImageModel('lib/assets/slider/slider1.png'),
    ImageModel('lib/assets/slider/slider2.png'),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class ImageModel {
  final String imageUrl;

  ImageModel(this.imageUrl);
}
