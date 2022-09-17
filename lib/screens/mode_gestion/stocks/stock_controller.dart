

// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class StockController extends GetxController{
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  final LocalAuthentificationService _localAuth = LocalAuthentificationServiceImpl();


  LoadingStatus infinityStatus = LoadingStatus.initial;

  final MedicamentService _medicamentService = MedicamentServiceImpl();

  List<Medicament> medicamentsList = <Medicament>[];
  RxInt selectedCategorieIndex = 0.obs;
  
  l.LocationData? currentLocation;
  double distance = 5; // initialisation du rayon de recherche à 5 KM par défaut

  int _count = 0;
  var next, previous;
  bool  is_searching  = false;
  String searchCategory = "Tous";

  GlobalKey<ScaffoldState> stockScaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    stockScaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() async {
    await getCurrentLocation();
    await getMedicamentsList();
    await listerner();
    super.onInit();
  }

  Future listerner() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if ( (next != null && next != null && !is_searching) ) {
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
  
  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    stockScaffoldKey.currentState!.dispose();
    super.dispose();
  }

   Future getCurrentLocation() async {
    infinityStatus = LoadingStatus.searching;
    update();
    l.Location location = l.Location();
    currentLocation = await location.getLocation();

    bool _serviceEnabled;
    l.PermissionStatus _permissionGranted;
    l.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print("Service indisponible !");
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("Service toujours indisponible !");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied) {
      print("Permission refusée !");
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != l.PermissionStatus.granted) {
        print("Permission not garented !");
        return;
      }
    }

    location.onLocationChanged.listen((l.LocationData newLocation) {
       currentLocation = newLocation;
    });
    update();
   
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


  Future getMedicamentsList() async {
    infinityStatus = LoadingStatus.searching;
    update();
    List<int> selectedVoix = [];
    for (Map<String, dynamic> v in voix ) {
      if (v['selected']){
        selectedVoix.add(v['id']);
      }
    }
    await _medicamentService.medicamentForPharmacy(
        url: next,
        data: {
            "query": [
              {"categorie": categories[selectedCategorieIndex.value]['libelle'] },
              {"voix": selectedVoix },
              {"search": searchController.text.trim() },
            ]
          },
          idPharmacie: await _localAuth.getPharmacyId(),
        onSuccess: (data) async {
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
      medicamentsList.clear();
      await getMedicamentsList();
      update();
    }
  }

  void changeVoix(int index) {
    voix[index]['selected'] = !voix[index]['selected'];
    update();
  }


  Future filterMedicamentsList() async {
    next = null;
    medicamentsList.clear();
    await getMedicamentsList();
    update();
  }

  Future searchData(String data) async {
    if (data.trim().length > 2) {
      next=null;
      medicamentsList.clear();
      await getMedicamentsList();
    }
  }

  List<Widget> drawerItems = [
    DrawerMenuItem(
      title: "Stocks",
      iconData: Icons.home_outlined,
      onTap: () {
        Get.back();
      },
    ),
    DrawerMenuItem(
      title: "Dashbord",
      iconData: Icons.dashboard_outlined,
      onTap: () {
        Get.offAndToNamed(AppRoutes.DASHBORD);
      },
    ),
    DrawerMenuItem(
      title: "Mouvements de stock",
      iconData: CupertinoIcons.gift_alt_fill,
      onTap: () {
        Get.offAndToNamed(AppRoutes.MOUVEMENT_STOCK);
      },
    ),
    DrawerMenuItem(
      title: "Factures",
      iconData: Icons.dashboard_outlined,
      onTap: () {
        Get.offAndToNamed(AppRoutes.FACTURES);
      },
    ),
    DrawerMenuItem(
      title: "Inventaire",
      iconData: Icons.dashboard_outlined,
      onTap: () {
        Get.offAndToNamed(AppRoutes.INVENTAIRES);
      },
    ),
    DrawerMenuItem(
      title: "Entrepôt/Magasin",
      iconData: Icons.warehouse_rounded,
      onTap: () {
        Get.offAndToNamed(AppRoutes.ENTREPOT);
      },
    ),
    DrawerMenuItem(
      title: "Mode visiteur",
      iconData: Icons.settings_applications,
      onTap: () {
        Get.offAllNamed(AppRoutes.HOME);
      },
    ),
   
  ];


}