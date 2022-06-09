import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mapview/mapview.dart';

class MapViewScreen extends GetView<MapViewScreenController> {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapViewScreenController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.onPositionChange,
            label: const Text('To the lake!'),
            icon: const Icon(Icons.directions_boat),
          ),
            body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: controller.kGooglePlex,
            onMapCreated: (GoogleMapController control) {
              controller.controller.complete(control);
            },
          ),
          ),
        );
      }
    );
  }
}


