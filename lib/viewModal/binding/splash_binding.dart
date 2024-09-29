import 'package:get/get.dart';
import 'package:inditab_task/viewModal/controller/spash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() { 
    Get.put(SplashController());
  }
}
