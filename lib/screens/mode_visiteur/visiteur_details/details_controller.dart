// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/database/Sync/synchronize.dart';
import 'package:pharmacy_app/database/models/medicament.dart' as lm;
import 'package:pharmacy_app/database/models/pharmacie.dart' as lp;
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class DetailScreenController extends GetxController {
  final MedicamentService _medicamentService = MedicamentServiceImpl();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  Medicament? medicament;
  // List<Facture> factures = <Facture>[];
  // int montantFactures = 0;
  // int quantiteTotalFacture = 0;

  // RxInt selectedIndex = 0.obs;

  bool isInternetConnection = false;

  @override
  void onInit() async {
    medicamentStatus = LoadingStatus.searching;
    isInternetConnection = await SynchronizationData.isInternet();
    if (!isInternetConnection) {
      lm.Medicament? medoc = await SynchronizationData().readMedicamentByIdMedicament(Get.arguments);
      medicament = medoc!.convert();
      lp.Pharmacie? pharmacie = await SynchronizationData().readPharmacieByIdPharmacie(medoc.pharmacie!);
      medicament!.pharmacies = [ pharmacie!.convert() ];
      medicamentStatus = LoadingStatus.completed;
      update();
    } else {
      await getMedicamentsById();
    }
    super.onInit();
  }

  Future getMedicamentsById() async {
    medicamentStatus = LoadingStatus.searching;
    update();
    await _medicamentService.getMedicamentsById(
        idMedicament: Get.arguments,
        onSuccess: (data) async {
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

          for (Pharmacie p in medicament!.pharmacies!){
            await SynchronizationData().savePharmacie(p.convert());
          }
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
