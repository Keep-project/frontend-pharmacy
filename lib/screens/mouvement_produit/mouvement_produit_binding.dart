

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mouvement_produit/mouvement_produit.dart';

class MouvementMedicamentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MouvementMedicamentController>(() => MouvementMedicamentController() );
  }
}