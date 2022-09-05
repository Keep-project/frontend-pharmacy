import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire/inventaire.dart';

class InventaireBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventaireController>(() => InventaireController());
  }
}
