import 'package:get/get.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form.dart';

class  MedicamentFormBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MedicamentFormController>(() => MedicamentFormController());
  }
}