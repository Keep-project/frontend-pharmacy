// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/inventaire_form/pages/pages.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';

class InventaireFormController extends GetxController{
  
final RemoteAuthenticationService _authService = RemoteAuthenticationServiceImpl();
LoadingStatus inventaireStatus = LoadingStatus.initial;


final PageController pageController = PageController();
int step = 1;

List<Map<String, dynamic>> entrepots = [
    {"id": 1, "libelle": "Magasin 1"},
    {"id": 2, "libelle": "Magasin 2"},
    {"id": 3, "libelle": "Magasin 3"},
    {"id": 4, "libelle": "Magasin 4"},
];

String selectedEntrepot = "Magasin 1";

  void onChangeEntrepot(dynamic data) {
    selectedEntrepot = data;
    update();
  }

  final List<Widget> pages = const <Widget>[
    PageOne(),
    PageTwo(),
  ];

  void jumpToStepTwo(BuildContext context) {
    
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 2;
    update();
  }

  void previousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step -= 1;
    update();
  }
  
}