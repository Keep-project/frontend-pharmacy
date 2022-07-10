import 'package:get/get.dart';
import 'package:pharmacy_app/screens/start/start.dart';


class StartScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartScreenController>(() => StartScreenController());
  }

}