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
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class MapViewScreenController extends GetxController {
  LoadingStatus pharmacyStatus = LoadingStatus.initial;
  final PharmacieService _pharmacieService = PharmacieServiceImpl();
  List<Pharmacie> pharmaciesList = <Pharmacie>[];
  Pharmacie? pharmacieDestination;

  TextEditingController textEditingControllerLocalisation =
      TextEditingController();

  final PageController pageController = PageController();

  final Completer<GoogleMapController> mapController = Completer();
  Rx<BitmapDescriptor> mapMarker =
      BitmapDescriptor.defaultMarkerWithHue(0.0).obs;

  List<LatLng> positions = <LatLng>[];

  int distance = 5; // initialisation du rayon de recherche à 5 KM par défaut

  CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 14.440717697143555,
      zoom: 13.151926040649414);

  CameraPosition? newCameraPosition;

  LatLng source = const LatLng(3.866667, 11.516667);
  LatLng destination = const LatLng(4.05, 9.7);
  LatLng newdestination = const LatLng(0, -0);
  double km = 0;

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
    await getCurrentLocation();
    //await getPolyPoints();
    super.onInit();
  }

  Future<void> onSlidePharmacie(int value) async {
    _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
          pharmaciesList[value].latitude!, pharmaciesList[value].longitude!),
      tilt: 59.440717697143555,
      zoom: 10.151926040649414,
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    update();
  }

  Future getPharmacies() async {
    pharmacyStatus = LoadingStatus.searching;
    pharmaciesList.clear();
    positions.clear();
    
    update();
    await _pharmacieService.findAll(
      longitude: currentLocation!.longitude ?? 11.516667,
      latitude: currentLocation!.latitude ?? 3.866667,
      distance: distance ,
      onSuccess: (data) async {
        pharmaciesList.addAll(data.results!);
        if (pharmaciesList.isNotEmpty){
          km = pharmaciesList[0].distance!;
        }
        for (Pharmacie p in data.results!) {
          positions.add(LatLng(p.latitude!, p.longitude!));
          /*if ( p.distance! < km && p.distance! >= 0 ) {
            km = p.distance!;
            pharmacieDestination = p;
            newdestination = LatLng(p.latitude!, p.longitude!);
          }*/
        }
        // destination = newdestination;
        ///////////////////
        /// Test
        print("============================");
        print(source);
        print("============================");
        // source = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
        /// destination = LatLng(pharmaciesList[1].latitude!, pharmaciesList[1].longitude!);
        //update();
        ///////////////////
        await getPolyPoints();
        
      pharmacyStatus = LoadingStatus.completed;
      update();
    },
    onError: (error) {
      print("============================");
      print(error);
      print("============================");
      pharmacyStatus = LoadingStatus.failed;
      update();
    });
  }

  Future filterPharmacies() async {
    pharmacyStatus = LoadingStatus.searching;
    pharmaciesList.clear();
    positions.clear();
    update();
    await _pharmacieService.filter(
      search: textEditingControllerLocalisation.text.trim(),
      onSuccess: (data) {
        
        pharmaciesList.addAll(data.results!);
        for (Pharmacie p in data.results!) {
          positions.add(LatLng(p.latitude!, p.longitude!));
        }
    
        pharmacyStatus = LoadingStatus.completed;
        update();
    }, onError: (error) {
      print("============================");
      print(error);
      print("============================");
      pharmacyStatus = LoadingStatus.failed;
      update();
    });
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
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      update();
    }
  }


  Future getCurrentLocation() async {
    pharmacyStatus = LoadingStatus.searching;
    update();
    l.Location location = l.Location();
    currentLocation = await location.getLocation();

    /*if ( currentLocation !=  null ) {
      source = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      update();
    }*/

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
   
    kGooglePlex = CameraPosition(
      target: LatLng(
          currentLocation!.latitude!,
          currentLocation!
              .longitude!), // Initialisation de la position sur Yaoundé
      zoom: 10.4746,
    );
    final GoogleMapController control = await mapController.future;
    control.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
    await getPharmacies();


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
    update();
    //when map drag stops
    List<Placemark> placemarks = await placemarkFromCoordinates(
        newCameraPosition!.target.latitude,
        newCameraPosition!.target.longitude
    );
    localisationInformations = placemarks.first;

    update();
  }

  // Clear Location
  Future<void> clearLocation() async {
    textEditingControllerLocalisation.clear();
    coordinates = [];
    predictions = [];
    localisationInformations = null;
    await getPharmacies();
    update();
  }

  Future<void> onPositionChange() async {
    final GoogleMapController control = await mapController.future;
    control.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void onJumpToOtherPage(int page) {
    pageController.jumpToPage(page);
    update();
  }
}
