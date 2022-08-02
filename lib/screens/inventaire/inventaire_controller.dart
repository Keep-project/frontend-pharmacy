
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventaireController extends GetxController {

  TextEditingController searchController = TextEditingController();

  // Catégorie  selectionnée par defaut
  RxInt selectedCategorieIndex = 0.obs;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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

}