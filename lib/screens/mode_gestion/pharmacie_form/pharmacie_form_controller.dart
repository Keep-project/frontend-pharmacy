// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:pharmacy_app/core/api_key.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:location/location.dart' as l;
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pages/page_one.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pages/page_two.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class PharmacieFormScreenController extends GetxController {
  LoadingStatus pharmacieStatus = LoadingStatus.initial;

  final PharmacieService _pharmacieService =
      PharmacieServiceImpl();
  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingEmail = TextEditingController();
  final TextEditingController textEditingPhone = TextEditingController();
  final TextEditingController textEditingPays = TextEditingController();
  final TextEditingController textEditingQuartier = TextEditingController();
  final TextEditingController textEditingVille = TextEditingController();
  final TextEditingController textEditingControllerLocalisation = TextEditingController();

  TimeOfDay ouverture = TimeOfDay.now();
  TimeOfDay fermeture = TimeOfDay.now();

  final PageController pageController = PageController();
  int step = 1;

final Completer<GoogleMapController> mapController = Completer();
  Rx<BitmapDescriptor> mapMarker =
      BitmapDescriptor.defaultMarkerWithHue(0.0).obs;
  
  LatLng position = const LatLng(3.866667, 11.516667);

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 14.440717697143555,
      zoom: 13.151926040649414);

  CameraPosition? newCameraPosition;

  l.LocationData? currentLocation;

  final String apiKey = GoogleApiKey.GOOGLE_API_KEY;
  late GooglePlace googlePlace;

  List<AutocompletePrediction> predictions = <AutocompletePrediction>[];
  List<double> coordinates = <double>[];

  Placemark? localisationInformations;
  String searchText = "";



 CameraPosition kGooglePlex = const CameraPosition(
    //bearing: 192.8334901395799,
    target: LatLng(3.866667, 11.516667), // Initialisation de la position sur Yaoundé
    //target: LatLng(37.4219983, -122.084),
    tilt: 14.440717697143555,
    zoom: 3.151926040649414
  );

  @override
  void onInit() async {
    googlePlace = GooglePlace(apiKey);
    super.onInit();
  }

  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingEmail.dispose();
    textEditingControllerLocalisation.dispose();
    textEditingPays.dispose();
    textEditingPhone.dispose();
    textEditingQuartier.dispose();
    textEditingVille.dispose();
    super.dispose();
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
      print("==================================");
      print(localisationInformations);
      print("==================================");
      position = LatLng(newCameraPosition!.target.latitude, newCameraPosition!.target.longitude);
      textEditingPays.text = localisationInformations!.country!;
      textEditingVille.text = localisationInformations!.administrativeArea!;
      textEditingQuartier.text = localisationInformations!.subAdministrativeArea!;

      

      //loadingLocation = LoadingStatus.completed;

    }
    else {
      print("==================================");
      print(details);
      print("==================================");
    }
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


  final List<Widget> pages = const <Widget>[PageOne(), PageTwo()];

  void jumpToStepTwo(BuildContext context) {

    if (textEditingNom.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez renseigner le nom de votre pharmacie");
      return;
    }
    if (!GetUtils.isEmail(textEditingEmail.text.trim())) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrez une adresse mail correcte !");
      return;
    }

    if (!GetUtils.isPhoneNumber(textEditingPhone.text.trim())) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrez un contact téléphonique correcte !");
      return;
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 2;
    update();
  }


  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step -= 1;
    update();
  }

  Future addPharmacy(BuildContext context) async {
    
    if (textEditingPays.text.trim().isEmpty ) {
      CustomSnacbar.showMessage(
          context, "Le champs pays doit être renseigné!");
      return;
    }
    if (textEditingVille.text.trim().isEmpty ) {
      CustomSnacbar.showMessage(
          context, "Le champs ville doit être renseigné!");
      return;
    }

    PharmacieRequestModel pharmacieModel = PharmacieRequestModel(
      nom: textEditingNom.text.trim(),
      localisation: "${textEditingPays.text.trim()};${textEditingVille.text.trim()};${textEditingQuartier.text.trim()}",
      phone: textEditingPhone.text.trim(),
      email: textEditingEmail.text.trim(),
      latitude: position.latitude,
      longitude: position.longitude,
      ouverture: ouverture.format(context),
      fermeture: fermeture.format(context),  
    );
    pharmacieStatus = LoadingStatus.searching;
    update();
    await _pharmacieService.add(
      pharmacieModel: pharmacieModel,
      onSuccess: (data) {
        CustomSnacbar.showMessage(
            context, "Pharmacie créée avec succès !");
        pharmacieStatus = LoadingStatus.completed;
        Get.offAndToNamed(AppRoutes.PHARMACIE_USER);
        update();
      },
      onError: (error) {
        print("============ pharmacy / error ===========");
        print(error.response!.statusCode);
        print(error.response!);
        if (error.response!.statusCode == 400) {
          CustomSnacbar.showMessage(
              context, "${error.response!.data['message']}");
        }
        print("=================================");
        pharmacieStatus = LoadingStatus.failed;
        update();
      },
    );
  }
  
  Future getOpenTimePicker(BuildContext context) async {
    var t1 = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    );
    if (t1 == null) { return; }
    ouverture = t1; 
    update();
  }

 

  Future getCloseTimePicker(BuildContext context) async {
    var t1 = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    );
    if (t1 == null) { return; }
    fermeture = t1;
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

  Future onCameraIdle() async {
    update();
    //when map drag stops
    List<Placemark> placemarks = await placemarkFromCoordinates(
        newCameraPosition!.target.latitude,
        newCameraPosition!.target.longitude
    );
    position = LatLng(newCameraPosition!.target.latitude, newCameraPosition!.target.longitude);
    localisationInformations = placemarks.first;

    textEditingPays.text = localisationInformations!.country!;
    textEditingVille.text = localisationInformations!.administrativeArea!;
    textEditingQuartier.text = localisationInformations!.subAdministrativeArea!;

    update();
  }
}
