// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/database/models/categorie.dart';
import 'package:pharmacy_app/database/sqflite_db.dart';

class StartScreenController extends GetxController {

  List<Categorie> categories = <Categorie>[];

  @override
  void onInit() async {
    await getCurrentLocation();
    categories = await PharmacieDatabase.instance.readAllCategorie();
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
