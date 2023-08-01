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
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class MapViewScreenController extends GetxController {
  LoadingStatus pharmacyStatus = LoadingStatus.initial;
  final PharmacieService _pharmacieService = PharmacieServiceImpl();
  List<Pharmacie> pharmaciesList = <Pharmacie>[];
  Rx<Pharmacie>? pharmacieDestination;

  TextEditingController textEditingControllerLocalisation =
      TextEditingController();

  final PageController pageController = PageController();

  final Completer<GoogleMapController> mapController = Completer();
  Rx<BitmapDescriptor> mapMarker =
      BitmapDescriptor.defaultMarkerWithHue(0.0).obs;

  Rx<BitmapDescriptor> sourceMapMarker =
      BitmapDescriptor.defaultMarkerWithHue(240.0).obs;

  List<LatLng> positions = <LatLng>[];

  RxBool searchForSomeBody = false.obs;

  TextEditingController textEditingDistance = TextEditingController();
  TextEditingController textEditingPays = TextEditingController();
  TextEditingController textEditingVille = TextEditingController();
  TextEditingController textEditingQuartier = TextEditingController();

  CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 14.440717697143555,
      zoom: 13.151926040649414);

  CameraPosition? newCameraPosition;

  Rx<LatLng> source = const LatLng(3.866667, 11.516667).obs;
  Rx<LatLng> destination = const LatLng(4.05, 9.7).obs;

  List<LatLng> polylineCoordinates = <LatLng>[];

  l.LocationData? currentLocation;

  final String apiKey = GoogleApiKey.GOOGLE_API_KEY;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = <AutocompletePrediction>[];
  List<double> coordinates = <double>[];

  Placemark? localisationInformations;
  String searchText = "";

  l.Location location = l.Location();

  @override
  void onInit() async {
    textEditingDistance.text = '25000';
    sourceMapMarker.value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/bonhomme3.png");
    googlePlace = GooglePlace(apiKey);
    await getCurrentLocation();
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

  void changeValue(bool value) {
    searchForSomeBody.value = value;
    update();
  }

  Future getPharmacies({BuildContext? context}) async {
    pharmacyStatus = LoadingStatus.searching;
    pharmaciesList.clear();
    positions.clear();

    if (searchForSomeBody.value) {
      if (textEditingPays.text.trim().isEmpty) {
        CustomSnacbar.showMessage(
            context!, "Veuillez renseigner le pays pour la recherche !");
      }
      if (textEditingVille.text.trim().isEmpty) {
        CustomSnacbar.showMessage(
            context!, "Veuillez renseigner la ville pour la recherche !");
      }
    }

    update();
    await _pharmacieService.findAll(
        longitude: currentLocation!.longitude ?? 0,
        latitude: currentLocation!.latitude ?? 0,
        distance: int.parse(textEditingDistance.text.trim()),
        search: textEditingControllerLocalisation.text.trim(),
        pays: textEditingPays.text.trim(),
        ville: textEditingVille.text.trim(),
        quartier: textEditingQuartier.text.trim(),
        onSuccess: (data) async {
          pharmaciesList.addAll(data.results!);
          if (currentLocation!.longitude! != 0 &&
              currentLocation!.latitude! != 0) {
            pharmaciesList.sort((a, b) => a.distance!.compareTo(b.distance!));
          }
          for (Pharmacie p in pharmaciesList) {
            positions.add(LatLng(p.latitude!, p.longitude!));
          }
          if (pharmaciesList.isNotEmpty) {
            pharmacieDestination?.value = pharmaciesList[0];
            destination.value = LatLng(
                pharmaciesList[0].latitude!, pharmaciesList[0].longitude!);
          }
          if (!searchForSomeBody.value) {
            await getPolyPoints();
          }

          pharmacyStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print(error);
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
        onSuccess: (data) async {
          pharmaciesList.addAll(data.results!);
          pharmaciesList.sort((a, b) => a.distance!.compareTo(b.distance!));
          for (Pharmacie p in pharmaciesList) {
            positions.add(LatLng(p.latitude!, p.longitude!));
          }
          if (pharmaciesList.isNotEmpty) {
            pharmacieDestination?.value = pharmaciesList[0];
            destination.value = LatLng(
                pharmaciesList[0].latitude!, pharmaciesList[0].longitude!);
          }
          await getPolyPoints();
          pharmacyStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print(error);
          pharmacyStatus = LoadingStatus.failed;
          update();
        });
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(
        3.866667, 11.516667), // Initialisation de la position sur Yaoundé
    //target: LatLng(37.4219983, -122.084),
    zoom: 10.4746,
  );

  Future getPolyPoints() async {
    update();
    PolylinePoints polyPoints = PolylinePoints();
    try {
      PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
          apiKey,
          PointLatLng(source.value.latitude, source.value.longitude),
          PointLatLng(destination.value.latitude, destination.value.longitude));

      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
        update();
      }
    } catch (e) {
      print("erreur : ");
    }
  }

  Future getCurrentLocation() async {
    pharmacyStatus = LoadingStatus.searching;
    update();

    currentLocation = await location.getLocation();

    if (currentLocation != null) {
      source.value =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      update();
    }

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

    // location.onLocationChanged.listen((l.LocationData newLocation) {
    //   currentLocation = newLocation;
    //   source.value =
    //       LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    // });
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
        newCameraPosition!.target.longitude);
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
