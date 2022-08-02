import 'package:get/get.dart';
import 'package:pharmacy_app/screens/inventaire/inventaire.dart';

class InventaireBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventaireController>(() => InventaireController());
  }
}
