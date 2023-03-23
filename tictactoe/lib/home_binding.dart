
import 'package:get/get.dart';
import 'package:untitled/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeController1>(() => HomeController1());
    Get.lazyPut<HomeController2>(() => HomeController2());
  }

}