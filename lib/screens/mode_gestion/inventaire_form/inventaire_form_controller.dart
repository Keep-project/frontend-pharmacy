// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire_form/pages/pages.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/entrepot/entrepot.dart';
import 'package:pharmacy_app/services/remote_services/inventaire/inventaire.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class InventaireFormController extends GetxController {

  TextEditingController searchController = TextEditingController();

  LoadingStatus infinityStatus = LoadingStatus.initial;
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  final InventaireService _inventaireService = InventaireServiceImpl();

  LoadingStatus inventaireStatus = LoadingStatus.initial;

  List<Entrepot> entrepotList = <Entrepot>[];
  final EntrepotService _entrepotService = EntrepotServiceImpl();

  final PageController pageController = PageController();

  int step = 1;

  List<Map<String, dynamic>> entrepots = [
    {"id": -1, "libelle": "Magasin-100"},
  ];

  int _count = 0;
  var next, previous;
  bool is_searching = false;

  List<Medicament> medicamentsList = <Medicament>[];

  final MedicamentService _medicamentService = MedicamentServiceImpl();


  TextEditingController textEditingLibelle = TextEditingController();

  String selectedEntrepot = "Magasin-100";

  List<Medoc> lignesProduits = <Medoc>[];
  String quantiteReelle = "";


  @override
  void onInit() async {
    await getEntrepot();
    super.onInit();
  }

  Future save(BuildContext context) async {
    inventaireStatus = LoadingStatus.searching;
    update();
    List produits = [];
    lignesProduits.forEach((element) { produits.add( element.toMap()); });
    var data = {
      "libelle": textEditingLibelle.text.trim(),
      "entrepot": entrepots.firstWhere((element) => element['libelle'] == selectedEntrepot)['id'],
      "medicaments": produits,
    };
    await _inventaireService.add(
      data: data,
      onSuccess: (data){
        CustomSnacbar.showMessage(
          context, data['message']);
          Get.toNamed(AppRoutes.INVENTAIRES);
        inventaireStatus = LoadingStatus.completed;
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
        inventaireStatus = LoadingStatus.failed;
        update();
      },
    );
  }

  void onChangeEntrepot(dynamic data) {
    selectedEntrepot = data;
    update();
  }

  final List<Widget> pages = const <Widget>[
    PageOne(),
    PageTwo(),
  ];

  void jumpToStepTwo(BuildContext context) {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 2;
    update();
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step -= 1;
    update();
  }

  Future getEntrepot() async {
    inventaireStatus = LoadingStatus.searching;
    update();

    await _entrepotService.getAll(
        idPharmacie: await _localAuth.getPharmacyId(),
        onSuccess: (data) async {
          for (dynamic item in data) {
            entrepots.add({
              'id': item['id'],
              'libelle': item['nom'],
            });
          }
          if (entrepots.length > 1) {
            selectedEntrepot = entrepots[1]['libelle'];
            entrepots.removeAt(0);
            entrepots.sort((a, b) => a['libelle'].compareTo(b['libelle']));
          }
          inventaireStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=============== Inventaire error ================");
          print(error);
          print("==========================================");
          inventaireStatus = LoadingStatus.failed;
          update();
        });
  }

  Future searchData(String data) async {
    if (data.trim().length > 1) {
      next = null;
      medicamentsList.clear();
      await getMedicamentsList();
    }
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

  void addLigneProduit(Medicament medicament) {
    lignesProduits.add(Medoc(
      id: medicament.id!,
      nom: medicament.nom!,
      stockAlert: medicament.stockAlert!,
      stockOptimal: medicament.stockOptimal!,
      stockAttendu: medicament.stock!,
      stockReel: int.parse(quantiteReelle.trim()),
      prix: medicament.prix,
    ));
    medicamentsList.clear();
    searchController.text = '';
    update();
  }
}

class Medoc {
  int? id;
  String? nom;
  int? stockAlert;
  int? stockOptimal;
  int? stockAttendu;
  int? stockReel;
  int? prix;

  Medoc(
      {this.id,
      this.nom,
      this.stockAlert,
      this.stockOptimal,
      this.stockAttendu,
      this.stockReel,
      this.prix});

  Map<String, dynamic> toMap() => {
        'id': id,
        'quantiteAttendue': stockAttendu,
        'quantiteReelle': stockReel,
      };
}
