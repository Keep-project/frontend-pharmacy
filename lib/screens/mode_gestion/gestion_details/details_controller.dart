// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/facture_model.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class DetailScreenController extends GetxController {
  final MedicamentService _medicamentService = MedicamentServiceImpl();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  Medicament? medicament;
  List<Facture> factures = <Facture>[];
  int montantFactures = 0;
  int quantiteTotalFacture = 0;

  RxInt selectedIndex = 0.obs;

  TextEditingController textEditingPrixVente = TextEditingController();
  TextEditingController textEditingNewStock = TextEditingController();

  @override
  void onInit() async {
    textEditingNewStock.text = '0';
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

  Future<void> updateStock(BuildContext context) async {
    print(textEditingPrixVente.text.trim());
    if ( selectedAction.value == "Ajouter"){
      medicament!.stock = medicament!.stock! + int.parse(textEditingNewStock.text.trim());
    }
    if ( selectedAction.value == "Supprimer" ){
      medicament!.stock = medicament!.stock! - int.parse(textEditingNewStock.text.trim());
    }
    update();
    await updateMedecine(context);
  }

  Future updateMedecine(BuildContext context) async {
    medicamentStatus = LoadingStatus.searching;
    update();
    
    var data = {
      'id': medicament!.id!,
      'nom': medicament!.nom!,
      'prix': int.parse(textEditingPrixVente.text.trim()),
      'marque': medicament!.marque!,
      'date_exp': medicament!.date_exp!.toIso8601String(),
      'masse': medicament!.masse!,
      'qte_stock': medicament!.stock!,
      'stockAlert': medicament!.stockAlert!,
      'stockOptimal': medicament!.stockOptimal!,
      'description': medicament!.description!,
      'posologie': medicament!.posologie!,
      'categorie': medicament!.categorie!,
      'pharmacie': medicament!.pharmacie,
      'entrepot': medicament!.entrepot,
      'voix': medicament!.voix!
    };

    await _medicamentService.update(
        idMedicament: medicament!.id!.toString(),
        data: data,
        onSuccess: (data) {
          Get.back();
          CustomSnacbar.showMessage(context, data['message']);
          medicament!.stock = data['results']['qte_stock'];
          medicament!.prix = data['results']['prix'];
          medicamentStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=======================================");
          print(error);
          print("=======================================");
          medicamentStatus = LoadingStatus.failed;
          update();
        });
  }

  Future getMedicamentsById() async {
    medicamentStatus = LoadingStatus.searching;
    update();
    await _medicamentService.getMedicamentsById(
        idMedicament: Get.arguments,
        onSuccess: (data) {
          medicament = data;
          textEditingPrixVente.text = medicament!.prix!.toString();
          factures = data!.references!;
          factures.forEach((element) {
            montantFactures += element.montantTotal!;
            element.produits!.forEach((item) {
              if (item.medicament! == medicament!.id!) {
                quantiteTotalFacture += item.quantite!;
              }
            });
          });
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
    print(data);
  }

  void onChangeEntrepotSource(dynamic data) {
    selectedEntrepotSource.value = data;
  }

  void onChangeEntrepotDestination(dynamic data) {
    selectedEntrepotDestination.value = data;
  }
}
