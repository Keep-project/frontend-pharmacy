
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class DetailEntrepotController extends GetxController {
  final ScrollController scrollController = ScrollController();
  LoadingStatus infinityStatus = LoadingStatus.initial;
  final MedicamentService _medicamentService = MedicamentServiceImpl();
  
  List<Medicament> medicamentsList = <Medicament>[];
  final LocalAuthentificationService _localAuth = LocalAuthentificationServiceImpl();

  int quantiteTotal = 0;

  int count = 0;
  var next, previous;
  bool  is_searching  = false;

  Entrepot entrepot = Entrepot();


  @override
  void onInit() async {
    if (Get.arguments != null) {
      entrepot = Get.arguments;
      await getMedicamentsList();
    }
    await listerner();
    super.onInit();
  }


  Future listerner() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if ( next != null && !is_searching ) {
          is_searching = true;
          infinityStatus = LoadingStatus.searching;
          update();
          Future.delayed(const Duration(seconds: 1), () async {
            await getMedicamentsList();
          });
        }
      }
    });
  }


  Future getMedicamentsList() async {
    infinityStatus = LoadingStatus.searching;
    update();
    
    await _medicamentService.medicamentsForEntrepot(
      url: next,
      idEntrepot: entrepot.id!.toString(),
        onSuccess: (data) async {
          count = data.count!;
          next = data.next;
          previous = data.previous;
          medicamentsList.addAll(data.results!);
          quantiteTotal = 0;
          medicamentsList.forEach((element) { quantiteTotal += element.stock!; });
          infinityStatus = LoadingStatus.completed;
          is_searching = false;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error.response);
          print("==========================================");
          infinityStatus = LoadingStatus.failed;
          update();
        }
    );
  }

}