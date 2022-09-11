// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables,

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/mode_visiteur/mapview/mapview.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  //await controller.onCameraIdle();
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: controller.polylineCoordinates,
                    color: kTextColor,
                    width: 6,
                  )
                },
                markers: {
                  ...List.generate(
                    controller.positions.length,
                    (index) => Marker(
                      markerId: MarkerId(
                          "point-id-${controller.pharmaciesList[index].id}"),
                      infoWindow: InfoWindow(
                          onTap: () {
                            controller.onJumpToOtherPage(index);
                          },
                          title: controller.pharmaciesList[index].nom
                              .toString()
                              .capitalizeFirst,
                          snippet:
                              "Tel: ${controller.pharmaciesList[index].phone}"),
                      icon: controller.mapMarker.value,
                      position: controller.positions[index],
                    ),
                  ),
                    controller.currentLocation != null
                      ? Marker(
                          markerId: const MarkerId("point-id-0"),
                          infoWindow: const InfoWindow(
                              title: "Localisation actuelle",
                              snippet: "Ici c'est votre position"),
                          icon: controller.mapMarker.value,
                          position: LatLng(
                              controller.currentLocation!.latitude!,
                              controller.currentLocation!.longitude!),
                        )
                     : const Marker(
                          markerId: MarkerId("point-id-2"),
                        ),
                  controller.pharmacieDestination != null
                      ? Marker(
                          markerId: const MarkerId("point-id-0"),
                          infoWindow: InfoWindow(
                              title: controller.pharmacieDestination!.nom!
                                  .toString(),
                              snippet:
                                  "Située à ${controller.pharmacieDestination!.distance!.toStringAsFixed(2)} Km"),
                          icon: controller.mapMarker.value,
                          position: LatLng(
                              controller.pharmacieDestination!.latitude!,
                              controller.pharmacieDestination!.longitude!),
                        )
                      : const Marker(
                          markerId: MarkerId("point-id-2"),
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
                                onChanged: (String value) async {
                                  if (value.toString().isNotEmpty) {
                                    await controller.filterPharmacies();
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
                                          unfocus();
                                          await controller.clearLocation();
                                        },
                                        child: const Icon(Icons.close,
                                            color: kTextColor2)),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Nom de la pharmacie",
                                    contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 8,
                                        bottom: 8,
                                        right: 10)),
                              ),
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding / 3),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Options(controller: controller));
                              },
                              child: const Icon(Icons.more_vert,
                                  size: 26, color: kDarkColor)),
                          const SizedBox(width: kDefaultPadding / 2),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              controller.pharmacyStatus == LoadingStatus.searching
                  ? Positioned(
                      bottom: kDefaultMargin / 2,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 140,
                        margin: const EdgeInsets.symmetric(
                            horizontal: kDefaultMargin),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultRadius)),
                        child: const Center(
                          child: CircularProgressIndicator(color: kTextColor),
                        ),
                      ),
                    )
                  : Container(),
              controller.pharmaciesList.isEmpty &&
                      controller.pharmacyStatus != LoadingStatus.searching
                  ? Positioned(
                      bottom: kDefaultMargin / 2,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 140,
                        margin: const EdgeInsets.symmetric(
                            horizontal: kDefaultMargin),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultRadius)),
                        child: const Center(
                          child: Text(
                            "Aucune pharmacie trouvée !!!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                  // controller.predictions.isNotEmpty
                  //     ? Positioned(
                  //         top: 60,
                  //         left: 20,
                  //         right: 20,
                  //         child: Container(
                  //             width: double.maxFinite,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 itemCount: controller.predictions.length,
                  //                 itemBuilder: (controll, ip) {
                  //                   return InkWell(
                  //                     onTap: () async {
                  //                       unfocus();
                  //                       await controller.onSelectPlace(ip);
                  //                     },
                  //                     child: Container(
                  //                       decoration: const BoxDecoration(),
                  //                       child: Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           ListTile(
                  //                               horizontalTitleGap: 0,
                  //                               leading: const Icon(Icons.room,
                  //                                   color: kOrangeColor,
                  //                                   size: kDefaultPadding),
                  //                               title: Text(
                  //                                   '${controller.predictions[ip].description}',
                  //                                   overflow: TextOverflow.ellipsis,
                  //                                   maxLines: 2,
                  //                                   style: const TextStyle(
                  //                                       color: kDarkColor,
                  //                                       fontSize: 15,
                  //                                       fontWeight:
                  //                                           FontWeight.bold))),
                  //                           controller.predictions.length - 1 != ip
                  //                               ? const Divider(
                  //                                   thickness: 2,
                  //                                 )
                  //                               : const Text(""),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 })),
                  //       )
                  : Positioned(
                      bottom: kDefaultMargin / 2,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 140,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: PageView.builder(
                          controller: controller.pageController,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding),
                                    decoration:
                                        const BoxDecoration(color: kTextColor),
                                    child: Row(children: [
                                      Text(
                                        controller.pharmaciesList[index].nom!
                                            .toString()
                                            .capitalize!,
                                        style: const TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          launchUrl(Uri.parse(
                                              "tel://${controller.pharmaciesList[index].phone!}"));
                                        },
                                        child: const Icon(CupertinoIcons.phone,
                                            size: 26, color: kWhiteColor),
                                      )
                                    ]),
                                  ),
                                  const Spacer(),
                                  Row(children: [
                                    const SizedBox(width: kDefaultPadding),
                                    const Icon(CupertinoIcons.gift_fill,
                                        size: 46, color: kTextColor),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tel: ${controller.pharmaciesList[index].phone!.toString()}",
                                          style: const TextStyle(
                                            color: kDarkColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                            wordSpacing: 1.2,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Text(
                                          "Ouverte de ${controller.pharmaciesList[index].ouverture!} à ${controller.pharmaciesList[index].fermeture!}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: kDarkColor.withOpacity(0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3,
                                            wordSpacing: 1.2,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Row(children: [
                                    const SizedBox(
                                        width: kDefaultPadding * 1.5),
                                    Text(
                                      "${index + 1}/${controller.pharmaciesList.length}",
                                      style: TextStyle(
                                        color: kDarkColor.withOpacity(0.6),
                                        fontSize: 16,
                                        height: 1.3,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text( "Située à ${controller.pharmaciesList[index].distance!.toStringAsFixed(2)} Km de votre position",
                                      style: const TextStyle(
                                        color: kOrangeColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                  ]),
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

class Options extends StatelessWidget {
  final dynamic controller;
  const Options({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius)),
      alignment: Alignment.center,
      child: Container(
        height: 228,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saisisez le rayon de recherche",
              style: TextStyle(
                fontSize: 18,
                color: kTextColor2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "en K.M",
              style: TextStyle(
                color: kDarkColor.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: kDefaultMargin / 2),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: kDefaultMargin * 1.5),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.5,
                  color: kTextColor2,
                ),
                borderRadius: BorderRadius.circular(kDefaultRadius / 2),
              ),
              child: TextField(
                onChanged: (String value) async {
                  if (value.toString().isNotEmpty) {
                    controller.distance = int.parse(value.trim());
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "rayon de recherche",
                    contentPadding: EdgeInsets.only(
                        left: 10, top: 3, bottom: 8, right: 10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    Get.back();
                    await controller.getPharmacies();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 45,
                    decoration: BoxDecoration(
                      color: kTextColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text(
                      "Rechercher",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultMargin / 2),
          ],
        ),
      ),
    );
  }
}
