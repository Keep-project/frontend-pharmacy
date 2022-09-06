

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/medicament_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/pages/page_one.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/pages/page_three.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/pages/page_two.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';



class MedicamentFormController extends GetxController {
  final MedicamentService _medicamentService =
      MedicamentServiceImpl();
  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPrixVente = TextEditingController();
  final TextEditingController textEditingMarque = TextEditingController();
  final TextEditingController textEditingMasseUnite = TextEditingController();
  final TextEditingController textEditingStock = TextEditingController();
  final TextEditingController textEditingStockAlert = TextEditingController();
  final TextEditingController textEditingStockOptimal = TextEditingController();
  final TextEditingController textEditingDescription = TextEditingController();
  final TextEditingController textEditingPosologie = TextEditingController();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  final LocalAuthentificationService _localAuth =  LocalAuthentificationServiceImpl();

  final PageController pageController = PageController();
  int step = 1;

  DateTime datePremption = DateTime.now();
  String datePremptionToString = '09/05/2007';

  final picker = ImagePicker();
  var imageFile;
  String photo = "";
  String imageName = "Aucune image choisie";


  List<Map<String, dynamic>> categories = [
    {"id": 1, "libelle": "Enfant"},
    {"id": 2, "libelle": "Adolescent"},
    {"id": 3, "libelle": "Adulte"},
    {"id": 4, "libelle": "Tous"},
  ];

  List<Map<String, dynamic>> tvas = [
    {"id": 1, "libelle": "19.25%"},
    {"id": 2, "libelle": "0%"},
  ];

  List<Map<String, dynamic>> baseprix = [
    {"id": 1, "libelle": "HT"},
    {"id": 2, "libelle": "TTC"},
  ];

  String selectedCategorie = "Enfant";
  String selectedTva = "19.25%";
  String selectedBasePrix = "HT";


  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingPrixVente.dispose();
    textEditingMarque.dispose();
    textEditingMasseUnite.dispose();
    textEditingStock.dispose();
    textEditingStockAlert.dispose();
    textEditingStockOptimal.dispose();
    textEditingDescription.dispose();
    textEditingPosologie.dispose();
    super.dispose();
  }


    Future chooseImage(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageName = pickedFile.name;
      var imageBytes = imageFile.readAsBytesSync();
      var encoded = base64Encode(imageBytes);
      photo = "data:image/png;base64, $encoded";
      update();
    }
  }

  void onChangeCategorie(dynamic data) {
    selectedCategorie = data;
    update();
  }

  void onChangeTva(dynamic data) {
    selectedTva = data;
    update();
  }

  void onChangeBasePrix(dynamic data) {
    selectedBasePrix = data;
    update();
  }

  final List<Widget> pages = const <Widget>[PageOne(), PageTwo(), PageThree()];

  void jumpToStepTwo(BuildContext context) {
    if (textEditingNom.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le nom du médicament !");
      return;
    }

    if (textEditingPrixVente.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le prix unitaire du médicament!");
      return;
    }

    if (textEditingMasseUnite.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner la masse de l'unité de ce médicament !");
      return;
    }
    if (textEditingStock.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner la quantié à mettre en stock pour ce médicament !");
      return;
    }

    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 2;
    update();
  }

  void jumpToStepThree(BuildContext context) {
    if (textEditingStockAlert.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le stock d'alerte du produit !");
      return;
    }
    if (textEditingStockOptimal.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le stock optimal du produit !");
      return;
    }

    if ( imageFile == null) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner une image du médicment !");
      return;
    }

    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 3;
    update();
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step -= 1;
    update();
  }

  Future addMedecine(BuildContext context) async {

    if (textEditingDescription.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner une petite description pour le médicament !");
      return;
    }

    if (textEditingPosologie.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner comment le médicament doit être pris ainsi que les conditions de conservation !");
      return;
    }
    var id = await _localAuth.getPharmacyId();
    MedicamentRequestModel new_medecine = MedicamentRequestModel(
      nom: textEditingNom.text.trim(),
      categorie: selectedCategorie == "Enfant" ? 1 : categories.firstWhere((c) => c['libelle'] == selectedCategorie)['id'],
      prix: int.parse(textEditingPrixVente.text.trim()),
      marque: textEditingMarque.text.trim(),
      masse: textEditingMasseUnite.text.trim(),
      qte_stock: int.parse(textEditingStock.text.trim()),
      stockAlert: int.parse(textEditingStockAlert.text.trim()),
      stockOptimal: int.parse(textEditingStockOptimal.text.trim()),
      tva: selectedTva == "19.25%" ? 19.25 : 0.0, // tvas.firstWhere((c) => c['libelle'] == selectedTva)['id'],
      basePrix: selectedBasePrix == "HT" ? "1" : baseprix.firstWhere((c) => c['libelle'] == selectedBasePrix)['id'].toString(),
      date_exp: datePremption,
      image: photo,
      description: textEditingDescription.text.trim(),
      posologie: textEditingPosologie.text.trim(),
      pharmacie: int.parse(id!),
      voix: 0,
      entrepot: 1,
    );

    // medicamentStatus = LoadingStatus.searching;
    update();
    await _medicamentService.add(
      medicamentModel: new_medecine,
      onSuccess: (data) {
        CustomSnacbar.showMessage(context, "Médicament ajouté avec succès !");
        Get.toNamed(AppRoutes.HOME);
        medicamentStatus = LoadingStatus.completed;
        update();
      },
      onError: (error) {
        print("============ Médicament form / error ===========");
        print(error.response!);
        if (error.response!.statusCode == 400) {
          CustomSnacbar.showMessage(context, "${error.response!.data['message']}");
        }
        print("=================================");
        medicamentStatus = LoadingStatus.failed;
        update();
      },
    );
  }
}
