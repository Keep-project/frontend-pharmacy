
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/stocks/stock.dart';

class StockBinding implements Bindings {

@override
void dependencies() {
  Get.lazyPut<StockController>(() => StockController());
}
}