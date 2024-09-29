import 'dart:async';

import 'package:get/get.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.put(HomePageController(),permanent: true);
    Timer(const Duration(milliseconds: 1500), () {
      Get.offAndToNamed('/home');
    });
  }
}
