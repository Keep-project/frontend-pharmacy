import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie/pharmacie.dart';


class PharmacieScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacieScreenController>(() => PharmacieScreenController());
  }

}