// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables,

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mapview/mapview.dart';

class MapViewScreen extends GetView<MapViewScreenController> {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapViewScreenController>(builder: (controller) {
      var currentFocus;
      void unfocus() {
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }

      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: controller.kGooglePlex,
                onMapCreated: (GoogleMapController control) {
                  controller.mapController.complete(control);
                },
                onCameraMove: (CameraPosition newCameraPosition) {
                  controller.newCameraPosition = newCameraPosition;
                  controller.update();
                },
                onCameraIdle: () async {
                  await controller.onCameraIdle();
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: controller.polylineCoordinates,
                    color: Colors.blue,
                    width: 6,
                  )
                },
                markers: {
                  ...List.generate(
                      controller.positions.length,
                      (index) => Marker(
                            markerId: MarkerId("point-id-$index"),
                            infoWindow: const InfoWindow(
                                title: "Localisation de la pharmacie",
                                snippet: "Une pharmacie de garde  24h/24"),
                            icon: controller.mapMarker.value,
                            position: controller.positions[index],
                          )),
                  controller.currentLocation != null
                      ? Marker(
                          markerId: const MarkerId("point-id-0"),
                          infoWindow: const InfoWindow(
                              title: "Current location",
                              snippet: "Ma position actuelle"),
                          icon: controller.mapMarker.value,
                          position: LatLng(
                              controller.currentLocation!.latitude!,
                              controller.currentLocation!.longitude!),
                        )
                      : const Marker(
                          markerId: MarkerId("point-id-2"),
                        ),
                  Marker(
                    markerId: const MarkerId("point-id-1"),
                    infoWindow: const InfoWindow(
                        title: "Localisation de la pharmacie source",
                        snippet: "Une pharmacie de garde  24h/24"),
                    icon: controller.mapMarker.value,
                    position: controller.source,
                  ),
                  Marker(
                    markerId: const MarkerId("point-id-2"),
                    infoWindow: const InfoWindow(
                        title: "Localisation de la pharmacie destination",
                        snippet: "Une pharmacie de garde  24h/24"),
                    icon: controller.mapMarker.value,
                    position: controller.destination,
                  ),
                },
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: kDefaultPadding / 1.5),
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(CupertinoIcons.arrow_left,
                                  size: 26, color: kDarkColor)),
                          const SizedBox(
                            width: kDefaultPadding / 1.5,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1.5,
                                  color: kTextColor2,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kDefaultRadius * 3),
                              ),
                              child: TextField(
                                controller: controller
                                    .textEditingControllerLocalisation,
                                onChanged: (String value) {
                                  if ((value.toString().isNotEmpty) &&
                                      (value.toString().trim() !=
                                          controller.searchText)) {
                                    controller.autoCompleteSearch(value);
                                  } else {
                                    controller.predictions = [];
                                    controller.update();
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.room,
                                        color: Colors.red, size: 24),
                                    suffixIcon: GestureDetector(
                                        onTap: () async {
                                          await controller.clearLocation();
                                        },
                                        child: const Icon(Icons.close,
                                            color: kTextColor2)),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Localisation",
                                    contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 8,
                                        bottom: 8,
                                        right: 10)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: kDefaultPadding,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              controller.predictions.isNotEmpty
                  ? Positioned(
                      top: 60,
                      left: 20,
                      right: 20,
                      child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.predictions.length,
                              itemBuilder: (controll, ip) {
                                return InkWell(
                                  onTap: () async {
                                    unfocus();
                                    await controller.onSelectPlace(ip);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                            horizontalTitleGap: 0,
                                            leading: const Icon(Icons.room,
                                                color: kOrangeColor,
                                                size: kDefaultPadding),
                                            title: Text(
                                                '${controller.predictions[ip].description}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: kDarkColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        controller.predictions.length - 1 != ip
                                            ? const Divider(
                                                thickness: 2,
                                              )
                                            : const Text(""),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    )
                  : Positioned(
                      bottom: kDefaultMargin / 2,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 140,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                        ),
                        child: PageView.builder(
                          itemCount: controller.pharmaciesList.length,
                          onPageChanged: (value) async {
                            controller.onSlidePharmacie(value);
                          },
                          itemBuilder: (context, index) => Card(
                            elevation: 10,
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(
                                horizontal: kDefaultMargin),
                            shadowColor: kTextColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    kDefaultRadius * 1.3)),
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric( horizontal: kDefaultPadding),
                                    decoration: const BoxDecoration(
                                      color: kTextColor
                                    ),
                                    child: Row(
                                      children: [
                                        Text(controller.pharmaciesList[index].nom!.toString().capitalize!,
                                          style: const TextStyle(
                                            color: kWhiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(CupertinoIcons.phone, size: 26, color: kWhiteColor)
                                      ]
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const SizedBox(width: kDefaultPadding),
                                      const Icon(CupertinoIcons.gift_fill, size: 46, color: kTextColor),
                                      const SizedBox(width: kDefaultPadding/2),
                                      Text("Tel: ${controller.pharmaciesList[index].phone!.toString()}",
                                        style: const TextStyle(
                                            color: kDarkColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                            wordSpacing: 1.2,
                                            fontStyle: FontStyle.italic,
                                          ),
                                      ),
                                     
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text((DateTime.now().hour >= controller.pharmaciesList[index].ouverture!.hour) && (DateTime.now().hour <= controller.pharmaciesList[index].fermeture!.hour) ? "Ouverte" : "Fermée",
                                        style: const TextStyle(
                                            color: kOrangeColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                      ),
                                       const SizedBox(width: kDefaultPadding),
                                    ]
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              
                            ),
                          ),
                        ),
                      )),
            ],
          ),
        ),
      );
    });
  }
}
