// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/facture/facture.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';


class FactureFormController extends GetxController {
  LoadingStatus factureStatus = LoadingStatus.initial;
  LoadingStatus infinityStatus = LoadingStatus.initial;

  TextEditingController searchController = TextEditingController();

  final FactureService _factureService = FactureServiceImpl();

  List<Medicament> medicamentsList = <Medicament>[];
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  TextEditingController textEditingReduction = TextEditingController();
  TextEditingController textEditingNote = TextEditingController();

  int _count = 0;
  var next, previous;
  bool is_searching = false;

  Medoc? selectedMedoc;
  List<Medoc> lignesProduits = <Medoc>[];

  final MedicamentService _medicamentService = MedicamentServiceImpl();

  DateTime dateFacturation = DateTime.now();
  String dateFacturationToString =
      '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';


  @override
  void onInit() async {
    textEditingReduction.text = '0';
    super.onInit();
  }

  Future searchData(String data) async {
    if (data.trim().length > 1) {
      next = null;
      medicamentsList.clear();
      await getMedicamentsList();
    }
  }

  Future save(BuildContext context) async {
    factureStatus = LoadingStatus.searching;
    update();
    List produits = [];
    lignesProduits.forEach((element) { produits.add( element.toMap()); });
    var data = {
      "note": textEditingNote.text.trim(),
      "reduction": int.parse(textEditingReduction.text.trim()),
      "montantTotal": montantTotal(),
      "quantiteTotal": quantiteTotal(),
      "medicaments": produits,
    };

    await _factureService.add(
      data: data,
      onSuccess: (data){
        CustomSnacbar.showMessage(
          context, data['message']);
          Get.toNamed(AppRoutes.FACTURES);
        factureStatus = LoadingStatus.completed;
        update();
      },
      onError: (error){
        print("===============================================");
        if (error.response!.statusCode == 401) {
          Get.offAllNamed(AppRoutes.LOGIN);
        }else {
          CustomSnacbar.showMessage(context, "Une erreur est survenue veuillez recommencer svp !");
        }
        print("===============================================");
        print(error.response);
        factureStatus = LoadingStatus.failed;
        update();
      },
    );
  }

  Future getMedicamentsList() async {
    infinityStatus = LoadingStatus.searching;
    update();

    await _medicamentService.medicamentForPharmacy(
        url: next,
        data: {
          "query": [
            {"search": searchController.text.trim()},
          ]
        },
        idPharmacie: await _localAuth.getPharmacyId(),
        onSuccess: (data) async {
          _count = data.count!;
          next = data.next;
          previous = data.previous;
          medicamentsList.addAll(data.results!);
          medicamentsList.sort((a, b) => a.nom!.compareTo(b.nom!));
          infinityStatus = LoadingStatus.completed;
          is_searching = false;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error.response);
          print("===========================================");
          infinityStatus = LoadingStatus.failed;
          update();
        });
  }

  void selectedMedicament(Medicament? medicament) {
    medicamentsList.clear();
    update();
    selectedMedoc = Medoc(
      id: medicament!.id!,
      nom: medicament.nom!,
      prix: medicament.prix!,
      stock: medicament.stock!,
      quantite: 1,
    );
    searchController.text = selectedMedoc!.nom!;
    update();
  }

  void ajouterLigneProduit() {
    medicamentsList.clear();
    searchController.text = '';
    lignesProduits.add(selectedMedoc!);
    selectedMedoc = null;
    update();
  }

  int montantTotal() {
    int somme = 0;
    for (Medoc medoc in lignesProduits) {
      somme += medoc.prix! * medoc.quantite!;
    }
    return somme;
  }

  int quantiteTotal() {
    int quantite = 0;
    for (Medoc medoc in lignesProduits) {
      quantite += medoc.quantite!;
    }
    return quantite;
  }

  void showMessage(BuildContext context, String nom) {
    CustomSnacbar.showMessage(context, "Vous venez de prendre tous $nom qu'il y avait en stock !");
  }
}

class Medoc {
  int? id;
  String? nom;
  int? prix;
  int? quantite;
  int? stock;

  Medoc({this.id, this.nom, this.prix, this.quantite, this.stock});


  Map<String, dynamic> toMap() => {
    'id': id,
    'prix': prix,
    'quantite': quantite,
  };
}
