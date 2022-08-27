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
  String searchCategory = "Tous";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() async {
    await medicamentList();
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
            if (selectedCategorieIndex.value == 0 && searchCategory == "Tous") {
              await medicamentList();
            }
            else {
              await filterList();
            }
          });
        }
      }
    });
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
      'id': 0,
      'libelle': 'Orale',
      'selected': false,
    },
    {
      'id': 1,
      'libelle': 'Injection',
      'selected': false,
    },
    {
      'id': 2,
      'libelle': 'Anale',
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

  Future filterList() async {
    infinityStatus = LoadingStatus.searching;
    update();
    List<int> selectedVoix = [];
    for (Map<String, dynamic> v in voix ) {
      if (v['selected']){
        selectedVoix.add(v['id']);
      }
    }
    await _medicamentService.filterList(
        url: next,
        data: {
            "query": [
              {"categorie": categories[selectedCategorieIndex.value]['libelle'] },
              {"voix": selectedVoix },
              {"search": searchController.text.trim() }
            ]
          },
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
          print(error.response);
          print("==========================================");
          infinityStatus = LoadingStatus.failed;
          update();
        }
    );
  }


  Future changeSelectedCategory(int index) async {

    if (selectedCategorieIndex.value != index) {
      selectedCategorieIndex.value = index;
      next = null;
      medicamentsList = [];
      switch (selectedCategorieIndex.value) {
        case 0:
          searchCategory = "Tous";
          await medicamentList();
          break;
        default:
          await filterList();
          break;
      }
      update();
    }
  }

  void changeVoix(int index) {
    voix[index]['selected'] = !voix[index]['selected'];
    update();
  }


  Future filterMedicamentsList({String? key}) async {
    next = null;
    medicamentsList = [];
    searchCategory = key!;
    if (searchController.text.isNotEmpty || key == "filter") {
      await filterList();
    }
    update();
  }
}