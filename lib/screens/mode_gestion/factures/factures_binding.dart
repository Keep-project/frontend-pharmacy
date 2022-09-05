import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/factures/factures.dart';

class FactureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FactureController>(() => FactureController());
  }
}
