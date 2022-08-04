import 'package:get/get.dart';
import 'package:pharmacy_app/screens/inventaire_form/inventaire_form.dart';

class  InventaireFormBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<InventaireFormController>(() => InventaireFormController());
  }
}