// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class PharmacieScreenController extends GetxController {
  LoadingStatus pharmacyStatus = LoadingStatus.initial;

  final PharmacieService _pharmacieService = PharmacieServiceImpl();
  List<Pharmacie> pharmaciesList = <Pharmacie>[];

  @override
  void onInit() async {
    await getCurrentLocation();
    await getPharmacies();
    super.onInit();
  }

  Future getPharmacies() async {
    pharmacyStatus = LoadingStatus.searching;
    update();
    await _pharmacieService.userPharmacies(onSuccess: (data) {
      pharmaciesList.addAll(data.results!);
      pharmacyStatus = LoadingStatus.completed;
      update();
    }, onError: (error) {
      print("============== pharmacie list / error ==============");
      print(error);
      print("====================================================");
      pharmacyStatus = LoadingStatus.failed;
      update();
    });
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
