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

  List<Map<String, dynamic>> tvas = [
    {"id": 1, "libelle": "19.25%"},
    {"id": 2, "libelle": "0%"},
  ];

  List<Map<String, dynamic>> baseprix = [
    {"id": 1, "libelle": "HT"},
    {"id": 2, "libelle": "TTC"},
  ];

  List<Map<String, dynamic>> actions = [
    {"id": 1, "libelle": "Ajouter"},
    {"id": 2, "libelle": "Supprimer"},
  ];

  List<Map<String, dynamic>> entrepots = [
    {"id": 1, "libelle": "Magasin 1"},
    {"id": 2, "libelle": "Magasin 2"},
    {"id": 3, "libelle": "Magasin 3"},
    {"id": 4, "libelle": "Magasin 4"},
    {"id": 5, "libelle": "Magasin 5"},
  ];

  RxString selectedTva = "19.25%".obs;
  RxString selectedBasePrix = "HT".obs;
  RxString selectedAction = "Ajouter".obs;
  RxString selectedEntrepotSource = "Magasin 1".obs;
  RxString selectedEntrepotDestination = "Magasin 2".obs;

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
          print(
              "====================== Medicament details / error =======================");
          print(error);
          print(error.response!.statusCode);
          print(
              "=========================================================================");
          medicamentStatus = LoadingStatus.failed;
          update();
        });
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  void onChangeTva(dynamic data) {
    selectedTva.value = data;
  }

  void onChangeBasePrix(dynamic data) {
    selectedBasePrix.value = data;
  }

  void onChangeAction(dynamic data) {
    selectedAction.value = data;
  }

  void onChangeEntrepotSource(dynamic data) {
    selectedEntrepotSource.value = data;
  }

  void onChangeEntrepotDestination(dynamic data) {
    selectedEntrepotDestination.value = data;
  }
}
