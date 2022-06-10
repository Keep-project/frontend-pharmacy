
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/dashbord/dashbord_controller.dart';


class DashbordScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<DashbordScreenController>(() => DashbordScreenController());
  }
}