

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/details.dart';

class DetailScreenBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<DetailScreenController>(() => DetailScreenController());
  }
}