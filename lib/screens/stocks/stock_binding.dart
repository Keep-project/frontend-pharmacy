
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/stocks/stock.dart';

class StockBinding implements Bindings {

@override
void dependencies() {
  Get.lazyPut<StockController>(() => StockController());
}
}