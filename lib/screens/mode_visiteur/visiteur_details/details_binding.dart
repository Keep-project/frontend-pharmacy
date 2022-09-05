

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_visiteur/visiteur_details/details.dart';

class DetailVisiteurScreenBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<DetailScreenController>(() => DetailScreenController());
  }
}