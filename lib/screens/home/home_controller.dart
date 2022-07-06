// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class HomeScreenController extends GetxController{
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();


  LoadingStatus infinityStatus = LoadingStatus.initial;

  final MedicamentService _medicamentService = MedicamentServiceImpl();

  List<Medicament> medicamentsList = <Medicament>[];
  RxInt selectedCategorieIndex = 0.obs;
  

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
    searchController.dispose();
    super.dispose();
  }


  List<Map<String, dynamic>> categories = [
    {
      'id': 1,
      'libelle': 'Tous'
    },
    {
      'id': 2,
      'libelle': 'Adolescents'
    },
    {
      'id': 3,
      'libelle': 'Enfants'
    },
    {
      'id': 4,
      'libelle': 'Adultes'
    },
  ];

  List<Map<String, dynamic>> voix = [
    {
      'id': 1,
      'libelle': 'Orale',
      'selected': false,
    },
    {
      'id': 2,
      'libelle': 'Anale',
      'selected': false,
    },
    {
      'id': 3,
      'libelle': 'Injection',
      'selected': false,
    },
    
  ];


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

  void changeSelectedCategory(int index) {
    selectedCategorieIndex.value = index;
    update();
  }

  void changeVoix(int index) {
    voix[index]['selected'] = !voix[index]['selected'];
    update();
  }


  Future filterMedicamentsList() async {

    print("filter médicaments");

    if (searchController.text.isNotEmpty) {
      print("Vous avez fait la recherche pour : ");
      print(searchController.text.trim());
    }
    
  }
}