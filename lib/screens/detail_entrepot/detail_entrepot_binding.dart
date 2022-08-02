

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/detail_entrepot/detail_entrepot.dart';

class DetailEntrepotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailEntrepotController>(() => DetailEntrepotController() );
  }
}