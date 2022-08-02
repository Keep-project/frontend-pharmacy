

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mouvement_stock/mouvement_stock.dart';

class MouvementStockBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MouvementStockController>(() => MouvementStockController() );
  }
}