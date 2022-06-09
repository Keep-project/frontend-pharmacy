

import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreenController extends GetxController{

  final Completer<GoogleMapController> controller = Completer();

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(3.866667, 11.516667),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(4.05, 9.7),
    zoom: 14.4746,
  );

  Future<void> onPositionChange() async {
    final GoogleMapController control = await controller.future;
    control.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}