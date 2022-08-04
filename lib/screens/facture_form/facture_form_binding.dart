import 'package:get/get.dart';
import 'package:pharmacy_app/screens/facture_form/facture_form.dart';

class  FactureFormBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<FactureFormController>(() => FactureFormController());
  }
}