

// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:pharmacy_app/core/api_key.dart';

class MapViewScreenController extends GetxController{

  TextEditingController textEditingControllerLocalisation = TextEditingController();

  final Completer<GoogleMapController> controller = Completer();

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final String apiKey = GoogleApiKey.GOOGLE_API_KEY;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = <AutocompletePrediction>[];
  List<double> coordinates = <double>[];

  Placemark? localisationInformations;
  String searchText = "";
  
  @override
  void onInit() {
    googlePlace = GooglePlace(apiKey);
    super.onInit();
  }

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(4.05, 9.7),
    zoom: 14.4746,
  );

  Future<void> onPositionChange() async {
    final GoogleMapController control = await controller.future;
    control.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  // Auto completion
  void autoCompleteSearch(String string) async {

    var result = await googlePlace.autocomplete.get(string);
    if (result != null && result.predictions != null) {
      //predictions = result.predictions!;
      print("=============================================================");
      print(result.predictions);
      print("=============================================================");
      update();
    }
  }

  // Select place function
  Future<void> onSelectPlace(int ip) async {
    //loadingLocation = LoadingStatus.searching;
    final placeId = predictions[ip].placeId!;
    predictions = [];
    final details = await googlePlace.details.get(placeId);
    update();
    if (details != null && details.result != null) {
      textEditingControllerLocalisation.text = details.result!.name.toString();
      coordinates = [
        details.result!.geometry!.location!.lat!,
        details.result!.geometry!.location!.lng!
      ];
      List<Placemark> placemarks = await placemarkFromCoordinates(
          details.result!.geometry!.location!.lat!,
          details.result!.geometry!.location!.lng!);
      localisationInformations = placemarks.first;
      //loadingLocation = LoadingStatus.completed;

    }
    update();
  }


  // Clear Location
  Future<void> clearLocation() async {
    textEditingControllerLocalisation.clear();
    coordinates = [];
    predictions = [];
    localisationInformations = null;
    update();
  }

}