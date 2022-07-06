// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class DashbordScreenController extends GetxController {
  int key = 0;
  int touchIndex = -1;

  Map<String, dynamic> dataMap = {
    'Electricity': 5,
    'Water': 2,
    'Food': 2,
    'Gas': 3,
  };

  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  DateTime now = DateTime.now();

  // @override
  // void onInit() {
  //   super.onInit();
  // }


  final ScrollController scrollController = ScrollController();
  LoadingStatus infinityStatus = LoadingStatus.initial;

  final MedicamentService _medicamentService = MedicamentServiceImpl();

  List<Medicament> medicamentsList = <Medicament>[];

  int _count = 0;
  var next, previous;
  bool  is_searching  = false;

  @override
  void onInit() async {
    await medicamentList();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if ( next != null && !is_searching ) {
          is_searching = true;
          infinityStatus = LoadingStatus.searching;
          update();
          Future.delayed(const Duration(seconds: 1), () async {
            await medicamentList();
          });
        }
      }
    });
    super.onInit();
  }
  
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future medicamentList() async {
    infinityStatus = LoadingStatus.searching;
    update();
    await _medicamentService.medicamentsList(
        url: next,
        onSuccess: (data) {
          _count = data.count!;
          next = data.next;
          previous = data.previous;
          medicamentsList.addAll(data.results!);
          infinityStatus = LoadingStatus.completed;
          is_searching = false;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
          infinityStatus = LoadingStatus.failed;
          update();
        }
    );
  }

  
}
