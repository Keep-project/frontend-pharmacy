

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_visiteur/mapview/mapview.dart';

class MapViewScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MapViewScreenController>(() => MapViewScreenController());
  }
}