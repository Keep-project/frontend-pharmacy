import 'package:get/get.dart';
import 'package:pharmacy_app/screens/rendez_vous/rendez_vous.dart';

class RendezVousScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RendezVousScreenController>(() => RendezVousScreenController());
  }
}