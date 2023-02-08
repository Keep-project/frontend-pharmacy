// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class DetailScreenController extends GetxController {
  final MedicamentService _medicamentService = MedicamentServiceImpl();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  Medicament? medicament;
  // List<Facture> factures = <Facture>[];
  // int montantFactures = 0;
  // int quantiteTotalFacture = 0;

  // RxInt selectedIndex = 0.obs;

  @override
  void onInit() async {
    await getMedicamentsById();
    super.onInit();
  }

  
  Future getMedicamentsById() async {
    medicamentStatus = LoadingStatus.searching;
    update();
    await _medicamentService.getMedicamentsById(
        idMedicament: Get.arguments,
        onSuccess: (data) {
          medicament = data;
          // factures = data!.references!;
          // factures.forEach((element){
          //   montantFactures += element.montantTotal!;
          //   element.produits!.forEach((item) {
          //     if (item.medicament! == medicament!.id!) {
          //       quantiteTotalFacture += item.quantite!;
          //     }
          //   });
          // });
          medicamentStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=========== Medicament details / error ==============");
          print(error);
          print("======================================================");
          medicamentStatus = LoadingStatus.failed;
          update();
        });
  }

  
}
