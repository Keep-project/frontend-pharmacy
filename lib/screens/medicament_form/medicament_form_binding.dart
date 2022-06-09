
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form_controller.dart';

class MedicamentFormScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MedicamentFormScreenController>(() => MedicamentFormScreenController());
  }
} 