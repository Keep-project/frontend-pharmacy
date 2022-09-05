

// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/models/response_data_models/facture_model.dart';

class DetailFactureController extends GetxController {

  Facture facture = Facture();

  @override
  void onInit() async {
    if ( Get.arguments != null){
      facture = Get.arguments;
    }
    super.onInit();
  }
}