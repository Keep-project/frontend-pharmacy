// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

import '../../models/response_data_models/medicament_model.dart';

class DetailScreenController extends GetxController {
  final MedicamentService _medicamentService = MedicamentServiceImpl();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  Medicament? medicament;

  RxInt selectedIndex = 0.obs; 


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
        medicamentStatus = LoadingStatus.completed;
        update();
      },
      onError: (error) {
        print("====================== Medicament details / error =======================");
        print(error);
        print(error.response!.statusCode);
        print("=========================================================================");
        medicamentStatus = LoadingStatus.failed;
        update();
      }
    );
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
