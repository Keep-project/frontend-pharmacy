import 'package:get/get.dart';
import 'package:pharmacy_app/screens/detail_facture/detail_facture.dart';

class DetailFactureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailFactureController>(() => DetailFactureController());
  }
}