
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_visiteur/medicaments/medicaments.dart';

class MedicamentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicamentscreenController>(() => MedicamentscreenController());
  }

}