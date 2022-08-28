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
import 'package:pharmacy_app/models/request_data_models/register_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/pharmacie_form/pages/pages.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';

class PharmacieFormScreenController extends GetxController {
  LoadingStatus pharmacieStatus = LoadingStatus.initial;

  final RemoteAuthenticationService _authService =
      RemoteAuthenticationServiceImpl();
  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingEmail = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();
  final TextEditingController textEditingControllerLocalisation = TextEditingController();

  final PageController pageController = PageController();
  int step = 1;

final Completer<GoogleMapController> mapController = Completer();
  Rx<BitmapDescriptor> mapMarker =
      BitmapDescriptor.defaultMarkerWithHue(0.0).obs;
  
  List<LatLng> positions = <LatLng>[];

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
    textEditingPassword.dispose();
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

      //loadingLocation = LoadingStatus.completed;

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

  Future register(BuildContext context) async {
    if (textEditingNom.text.trim().toString().length < 4 &&
        textEditingPassword.text.trim().toString().length < 8) {
      CustomSnacbar.showMessage(context,
          "Le champs nom doit avoir au moins 04 caractères et le champs mot de passe au moins 08 caractères !");
      return;
    }
    if (textEditingNom.text.trim().toString().length < 4) {
      CustomSnacbar.showMessage(
          context, "Le champs nom doit avoir au moins 04 caractères !");
      return;
    }
    if (textEditingPassword.text.trim().toString().length < 8) {
      CustomSnacbar.showMessage(context,
          "Le champs mot de passe doit avoir au moins 08 caractères !");
      return;
    }
    if (textEditingEmail.text.trim().toString().length < 10) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrez une adresse mail correcte !");
      return;
    }
    pharmacieStatus = LoadingStatus.searching;
    update();
    await _authService.register(
      registerReqModel: RegisterRequestModel(
        username: textEditingNom.text.trim(),
        email: textEditingEmail.text.trim(),
        password: textEditingPassword.text.trim(),
      ),
      onRegisterSuccess: (data) {
        CustomSnacbar.showMessage(
            context, "Compte créer avec succès !\nConnectez vous maintenant.");
        Get.offAndToNamed(AppRoutes.LOGIN);
        pharmacieStatus = LoadingStatus.completed;
        update();
      },
      onRegisterError: (error) {
        print("============ Register ===========");
        print(error.response!.statusCode);
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
  
    // Clear Location
  Future<void> clearLocation() async {
    textEditingControllerLocalisation.clear();
    coordinates = [];
    predictions = [];
    localisationInformations = null;
    update();
  }
}
