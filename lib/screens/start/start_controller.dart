// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/database/Sync/synchronize.dart';
import 'package:pharmacy_app/database/models/categorie.dart';
import 'package:pharmacy_app/database/models/entrepot.dart';
import 'package:pharmacy_app/database/models/medicament.dart';
import 'package:pharmacy_app/database/models/pharmacie.dart';
import 'package:pharmacy_app/database/sqflite_db.dart';
import 'package:pharmacy_app/models/request_data_models/medicament_model.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart'
    as rm;
import 'package:pharmacy_app/services/local_services/authentication/authentication_services.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentication_services_impl.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class StartScreenController extends GetxController {
  List<Categorie> categories = <Categorie>[];

  LoadingStatus synchronizeStatus = LoadingStatus.initial;
  final MedicamentService _medicamentService = MedicamentServiceImpl();
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  bool isInternetConnection = false;

  dynamic next, previous;
  int _count = 0;

  var medicaments;
  List<rm.Medicament> medicamentsList = [];

  @override
  void onInit() async {
    await getCurrentLocation();
    // await SynchronizationData().fetchAllNotes();
    isInternetConnection = await SynchronizationData.isInternet();
    // await PharmacieDatabase.instance.createCategorie(Categorie(libelle: 'Adultes'));
    // categories = await PharmacieDatabase.instance.readAllCategorie();
    // for (Categorie cat in categories) {
    //   print("\n\n");
    //   print(cat.toMap());
    // }
    // Pharmacie pharmacies = await PharmacieDatabase.instance.createPharmacie(
    //   Pharmacie(
    //     libelle: '1',
    //     nom: 'Pharmacie de la côte',
    //     localisation: "Cameroun;Yaoundé;Mvan",
    //     tel: "+237 652 310 829",
    //     latitude: 3.866667,
    //     longitude : 11.516667,
    //     ouverture: '08h30',
    //     fermeture: '19h30',
    //     created_at: DateTime.now(),
    //     updated_at: DateTime.now(),
    //     user: 1,
    //     email: 'info@gmail.com',
    //   )
    // );
    // var pharmacy = await PharmacieDatabase.instance.readAllPharmacie();
    // print(pharmacy.first.toMap());
    try {
      print("============================");
      // Entrepot entrepot = await PharmacieDatabase.instance.createEntrepot(Entrepot(
      //   nom: 'Magasin 1',
      //   pays: 'Cameroun',
      //   ville: 'Yaoundé',
      //   telephone: '652310829',
      //   description:
      //       'Entrepot de stockage de produits pharmaceutiques pour adultes',
      //   created_at: DateTime.now(),
      //   updated_at: DateTime.now(),
      //   pharmacie: pharmacy.first.id!,
      // ));
      // var entrepots = await PharmacieDatabase.instance.readAllEntrepot();
      // print(entrepots.first.toMap());
      /*Medicament medicament = await PharmacieDatabase.instance.createMedicament(
          Medicament(
              nom: "Versol",
              prix: 200,
              marque: "denk",
              dateExp: DateTime.now(),
              image: "",
              masse: "30g",
              qteStock: 194,
              stockAlert: 47,
              stockOptimal: 210,
              description: "médicament pour enfant",
              posologie: "deux comprimé chaque jour",
              voix: 1,
              categorie: 2,
              user: 2,
              pharmacie: 1,
              entrepot: 1,
              created_at: DateTime.now(),
              updated_at: DateTime.now(),));*/
      /*await PharmacieDatabase.instance.updateMedicament(Medicament(
              id: 1,
              nom: "Aclav",
              prix: 4300,
              marque: "denk",
              dateExp: DateTime.parse("2022-09-21T12:55:53.018Z"),
              image: "",
              masse: "200g",
              qteStock: 194,
              stockAlert: 1,
              stockOptimal: 1,
              description: "médicament pour enfant",
              posologie: "deux comprimÚ chaque jour",
              voix: 2,
              categorie: 1,
              user: 2,
              pharmacie: 1,
              entrepot: 1,
              created_at: DateTime.parse("2022-07-04T16:43:45.684Z"),
              updated_at: DateTime.parse("2022-09-26T05:48:34.878Z")));
      await PharmacieDatabase.instance.updateMedicament(Medicament(
              id: 2,
              nom: "Flucazol",
              prix: 4300,
              marque: "denk",
              dateExp: DateTime.parse("2022-09-21T12:55:53.018Z"),
              image: "",
              masse: "200g",
              qteStock: 194,
              stockAlert: 1,
              stockOptimal: 1,
              description: "médicament pour enfant",
              posologie: "deux comprimÚ chaque jour",
              voix: 2,
              categorie: 1.toString(),
              user: 2,
              pharmacie: 1.toString(),
              entrepot: 1.toString(),
              isUpdate: true,
              created_at: DateTime.parse("2022-07-04T16:43:45.684Z"),
              updated_at: DateTime.parse("2022-09-26T05:48:34.878Z")));*/

      medicaments = await SynchronizationData().pushMedicament(update:1);
      // print(isInternetConnection);
      print("Liste des médicament à mettre à jour");
      print(medicaments);
      print("=====================================");
    } catch (e) {
      print(e);
    }
    super.onInit();
  }

  Future getCurrentLocation() async {
    l.Location location = l.Location();

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

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((l.LocationData currentLocation) {
      // print(currentLocation);
    });

    update();
  }

  /** 
   * Synchronisation des bases de données 
   * 
   * */

  Future pushData(BuildContext context) async {
    synchronizeStatus = LoadingStatus.searching;
    update();
    for (var medoc in medicaments) {
      MedicamentRequestModel newmedecine =
          MedicamentRequestModel.fromMap(medoc.toMap());
      await _medicamentService.add(
        medicamentModel: newmedecine,
        onSuccess: (data) {
          print("${medoc.nom!} save successfully !\n\n");
          CustomSnacbar.showMessage(context, "Médicament ajouté avec succès !");
          // Get.offAndToNamed(AppRoutes.STOCK);
          // synchronizeStatus = LoadingStatus.completed;
          // update();
        },
        onError: (e) {
          print("============ Médicament form / error ===========");
          print(e.response);
          if (e.response!.statusCode == 400) {
            CustomSnacbar.showMessage(context, "${e.response!.data['message']}",
                height: 120);
          }
          print("=================================");
          // synchronizeStatus = LoadingStatus.failed;
          // update();
        },
      );
    }
    synchronizeStatus = LoadingStatus.completed;
    update();
  }

  Future pullData(BuildContext context) async {
    synchronizeStatus = LoadingStatus.searching;
    update();
    await _medicamentService.medicamentForPharmacy(
        url: next,
        data: {'None': null},
        idPharmacie: await _localAuth.getPharmacyId(),
        onSuccess: (data) async {
          _count = data.count!;
          next = data.next;
          previous = data.previous;
          medicamentsList.addAll(data.results!);
          for (rm.Medicament med in data.results!) {
            await SynchronizationData().saveMedicament(med);
          }
          if (next != null) {
            await pullData(context);
          } else {
            synchronizeStatus = LoadingStatus.completed;
            update();
          }
        },
        onError: (e) {
          print("=============== pull data error ================");
          print(e);
          print("==========================================");
          synchronizeStatus = LoadingStatus.failed;
          update();
        });
  }
}
