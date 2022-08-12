

// ignore_for_file: avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/core/api_key.dart';

class MapViewScreenController extends GetxController{

  TextEditingController textEditingControllerLocalisation = TextEditingController();

  final Completer<GoogleMapController> mapController = Completer();
  Rx<BitmapDescriptor> mapMarker =
      BitmapDescriptor.defaultMarkerWithHue(0.0).obs;
  
  List<LatLng> positions = <LatLng>[
    const LatLng(3.866667, 11.516667),
  ];

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 14.440717697143555,
      zoom: 13.151926040649414);

  CameraPosition? newCameraPosition;


  final LatLng source = const LatLng(3.866667, 11.516667);
  //final LatLng source = const LatLng(37.4219983, -122.084);
  final LatLng destination = const LatLng(4.05, 9.7);
  //final LatLng destination = const LatLng(3.97806, 11.5931);

  List<LatLng> polylineCoordinates = <LatLng>[];

  l.LocationData? currentLocation;


  final String apiKey = GoogleApiKey.GOOGLE_API_KEY;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = <AutocompletePrediction>[];
  List<double> coordinates = <double>[];

  Placemark? localisationInformations;
  String searchText = "";
  
  @override
  void onInit() async {
    googlePlace = GooglePlace(apiKey);
    await getPolyPoints();
    await getCurrentLocation();
    super.onInit();
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(3.866667, 11.516667), // Initialisation de la position sur Yaoundé
    //target: LatLng(37.4219983, -122.084),
    zoom: 10.4746,
  );

  Future getPolyPoints() async {
    PolylinePoints polyPoints = PolylinePoints();

    PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude)
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      update();
    }
  }

  Future getCurrentLocation() async {
    l.Location location = l.Location();
    await location.getLocation().then((location) => currentLocation = location);

    location.onLocationChanged.listen((newlocation)  => currentLocation = newlocation);
   
    kGooglePlex = CameraPosition(
      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), // Initialisation de la position sur Yaoundé
      zoom: 10.4746,
    );
    update(); 
  }



  // Auto completion
  void autoCompleteSearch(String string) async {
    var result = await googlePlace.autocomplete.get(string);
    if (result != null && result.predictions != null) {
      predictions = result.predictions!;
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
      //positions.add(LatLng(details.result!.geometry!.location!.lat!,
      //  details.result!.geometry!.location!.lng!));
      List<Placemark> placemarks = await placemarkFromCoordinates(
          details.result!.geometry!.location!.lat!,
          details.result!.geometry!.location!.lng!);
      localisationInformations = placemarks.first;

      //loadingLocation = LoadingStatus.completed;

    }
    update();
  }

  void setCustomMarker() async {
    //mapMarker.value = await BitmapDescriptor.fromAssetImage(
        //ImageConfiguration(), "assets/images/marker2.png");
    CameraPosition kLake = const CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(3.866667, 11.516667),
        tilt: 40.440717697143555,
        zoom: 19.151926040649414);
    final GoogleMapController control = await mapController.future;
    control.animateCamera(CameraUpdate.newCameraPosition(kLake));
    update();
  }

  Future onCameraIdle() async {
    //when map drag stops
    List<Placemark> placemarks = await placemarkFromCoordinates(
        newCameraPosition!.target.latitude,
        newCameraPosition!.target.longitude);

      positions.add(LatLng(newCameraPosition!.target.latitude, newCameraPosition!.target.longitude));
      localisationInformations = placemarks.first;

      print(positions);
    
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


  Future<void> onPositionChange() async {
    final GoogleMapController control = await mapController.future;
    control.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}