
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/entrepot/entrepot.dart';

class EntrepotBinding implements Bindings {

@override
void dependencies() {
  Get.lazyPut<EntrepotController>(() => EntrepotController());
}
}