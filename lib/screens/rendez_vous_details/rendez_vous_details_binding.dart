import 'package:get/get.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/rendez_vous_details.dart';

class RendezVousScreenDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RendezVousScreenControllerDetails>(() => RendezVousScreenControllerDetails());
  }
}