

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/pharmacie_form/pharmacie_form.dart';

class PharmacieFormScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<PharmacieFormScreenController>(() => PharmacieFormScreenController());
  }
}