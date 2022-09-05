
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/models/response_data_models/inventaire_model.dart';

class DetailInventaireController extends GetxController {

  // Catégorie  selectionnée par defaut
  RxInt selectedCategorieIndex = 0.obs;

  Inventaire inventaire = Inventaire();

  @override
  void onInit() async {
    if (Get.arguments != null){
      inventaire = Get.arguments;
    }
    super.onInit();
  }

  

}