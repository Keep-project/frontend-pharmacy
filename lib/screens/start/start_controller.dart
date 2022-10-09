// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/database/Sync/synchronize.dart';
import 'package:pharmacy_app/database/models/categorie.dart';
import 'package:pharmacy_app/database/models/entrepot.dart';
import 'package:pharmacy_app/database/models/medicament.dart';
import 'package:pharmacy_app/database/models/pharmacie.dart';
import 'package:pharmacy_app/database/sqflite_db.dart';

class StartScreenController extends GetxController {
  List<Categorie> categories = <Categorie>[];

  @override
  void onInit() async {
    await getCurrentLocation();
    // await SynchronizationData().fetchAllNotes();
    bool status = await SynchronizationData.isInternet();
    print(status);
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
      // Medicament medicament = await PharmacieDatabase.instance.createMedicament(
      //   Medicament(
      //     nom: "Spedifen",
      //     prix: 350,
      //     marque: "Denk",
      //     dateExp: DateTime.now(),
      //     image: '',
      //     masse: '12g',
      //     qteStock: 202,
      //     description: 'Medicament pour soulagement des maux de ...',
      //     posologie: 'A prendre chaque jour à la même heure',
      //     voix: 1,
      //     created_at: DateTime.now(),
      //     updated_at: DateTime.now(),
      //     categorie: 1,
      //     pharmacie: 1,
      //     user: 1,
      //     stockAlert: 40,
      //     stockOptimal: 410,
      //     entrepot: 1,
      //   )
      // );
      var medicaments = await PharmacieDatabase.instance.readAllMedicament();
      print(medicaments.first.toMap());
    print("============================");
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
}
