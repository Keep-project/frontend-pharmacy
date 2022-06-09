

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mapview/mapview.dart';

class MapViewScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MapViewScreenController>(() => MapViewScreenController());
  }
}