
// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/entrepot/entrepot.dart';

class EntrepotController extends GetxController {

  final ScrollController scrollController = ScrollController();
  final EntrepotService _entrepotService = EntrepotServiceImpl();

  final LocalAuthentificationService _localAuth = LocalAuthentificationServiceImpl();

  List<Entrepot> entrepotList = <Entrepot>[];

  TextEditingController searchController = TextEditingController();
  LoadingStatus infinityStatus = LoadingStatus.initial;
  String productName = "";

  // Catégorie  selectionnée par defaut
  RxInt selectedCategorieIndex = 0.obs;

  double distance = 5;

  int _count = 0;
  var next, previous;
  bool is_searching = false;
  String searchCategory = "Tous";

     GlobalKey<ScaffoldState> entrepotStockScaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    entrepotStockScaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() async {
    await getEntrepot();
    await listerner();
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    entrepotStockScaffoldKey.currentState!.dispose();
    super.dispose();
  }

  Future listerner() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (next.length > 0 && !is_searching) {
          is_searching = true;
          infinityStatus = LoadingStatus.searching;
          update();
          Future.delayed(const Duration(seconds: 1), () async {
            await getEntrepot();
          });
        }
      }
    });
  }

  Future getEntrepot() async {
    infinityStatus = LoadingStatus.searching;
    update();
    
    await _entrepotService.findAll(
        url: next,
        // data: {
        //     "query": [
        //       {"categorie": categories[selectedCategorieIndex.value]['libelle'] },
        //       {"voix": selectedVoix },
        //       {"search": searchController.text.trim() },
        //     ]
        //   },
        idPharmacie: await _localAuth.getPharmacyId(),
        onSuccess: (data) async {
          _count = data.count!;
          next = data.next;
          previous = data.previous;
          entrepotList.addAll(data.results!);
          infinityStatus = LoadingStatus.completed;
          is_searching = false;
          update();
        },
        onError: (error) {
          print("=============== Inventaire error ================");
          print("Last url : $next b");
          print(error);
          print("==========================================");
          infinityStatus = LoadingStatus.failed;
          update();
        });
  }



  // Liste des catégories de médicaments
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


  // Liste des voix de prise du médicament
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

  void changeSelectedCategory(int index) {
    selectedCategorieIndex.value = index;
    update();
  }

  void changeVoix(int index) {
    voix[index]['selected'] = !voix[index]['selected'];
    update();
  }

  
  // Méthode permettant de filtrer les médicaments
  Future filterMedicamentsList() async {
    print("Vous avez fait la recherche pour :");
    print(searchController.text.trim());
  }

      List<Widget> drawerItems = [
    DrawerMenuItem(
      title: "Stocks",
      iconData: Icons.home_outlined,
      onTap: () {
        Get.toNamed(AppRoutes.STOCK);
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
      title: "Mode visiteur",
      iconData: Icons.settings_applications,
      onTap: () {
        Get.offAllNamed(AppRoutes.HOME);
      },
    ),
   
  ];



}