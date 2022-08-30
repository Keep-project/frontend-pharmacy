// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/register_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/medicament_form/pages/pages.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';

class MedicamentFormController extends GetxController {
  final RemoteAuthenticationService _authService =
      RemoteAuthenticationServiceImpl();
  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPrixVente = TextEditingController();
  final TextEditingController textEditingMarque = TextEditingController();
  final TextEditingController textEditingMasseUnite = TextEditingController();
  final TextEditingController textEditingStock = TextEditingController();

  LoadingStatus medicamentStatus = LoadingStatus.initial;

  final PageController pageController = PageController();
  int step = 1;

  DateTime datePremption = DateTime.now();
  String datePremptionToString = '09/05/2007';

  final picker = ImagePicker();
  var imageFile;
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
    super.dispose();
  }


    Future chooseImage(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageName = imageFile.name;
      // var imageBytes = imageFile.readAsBytesSync();
      // var encoded = base64Encode(imageBytes);
      // photo = "data:image/png;base64, $encoded";
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
          context, "Veuillez renseigner le prix unitaire du médicament !");
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
    if (textEditingNom.text.trim().toString().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le nom du médicament !");
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
    if (textEditingNom.text.trim().toString().length < 4) {
      CustomSnacbar.showMessage(
          context, "Le champs nom doit avoir au moins 04 caractères !");
      return;
    }

    medicamentStatus = LoadingStatus.searching;
    update();
    await _authService.register(
      registerReqModel: RegisterRequestModel(
        username: textEditingNom.text.trim(),
      ),
      onRegisterSuccess: (data) {
        CustomSnacbar.showMessage(
            context, "Compte créer avec succès !\nConnectez vous maintenant.");
        Get.offAndToNamed(AppRoutes.LOGIN);
        medicamentStatus = LoadingStatus.completed;
        update();
      },
      onRegisterError: (error) {
        print("============ Register ===========");
        print(error.response!.statusCode);
        if (error.response!.statusCode == 400) {
          CustomSnacbar.showMessage(
              context, "${error.response!.data['message']}");
        }
        print("=================================");
        medicamentStatus = LoadingStatus.failed;
        update();
      },
    );
  }
}
