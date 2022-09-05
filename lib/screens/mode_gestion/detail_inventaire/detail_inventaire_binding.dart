import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/detail_inventaire/detail_inventaire.dart';

class DetailInventaireBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailInventaireController>(() => DetailInventaireController());
  }
}
