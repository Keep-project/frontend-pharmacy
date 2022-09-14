// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class FactureFormController extends GetxController{
  
LoadingStatus factureStatus = LoadingStatus.initial;
LoadingStatus infinityStatus = LoadingStatus.initial;

TextEditingController searchController = TextEditingController();

List<Medicament> medicamentsList = <Medicament>[];
final LocalAuthentificationService _localAuth = LocalAuthentificationServiceImpl();

int _count = 0;
var next, previous;
bool  is_searching  = false;

final MedicamentService _medicamentService = MedicamentServiceImpl();


DateTime dateFacturation = DateTime.now();
String dateFacturationToString = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
  
Future searchData(String data) async {
    if (data.trim().length > 1) {
      next=null;
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
              {"search": searchController.text.trim() },
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
        }
    );
  }

}