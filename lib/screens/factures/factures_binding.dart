import 'package:get/get.dart';
import 'package:pharmacy_app/screens/factures/factures.dart';

class FactureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FactureController>(() => FactureController());
  }
}
