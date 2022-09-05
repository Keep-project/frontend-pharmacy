import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/entrepot_form/entrepot_form.dart';

class  EntrepotFormBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<EntrepotFormController>(() => EntrepotFormController());
  }
}