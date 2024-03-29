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
                    color: Colors.blue,
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
                          icon: controller.sourceMapMarker.value,
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
                              title: controller.pharmacieDestination?.value.nom!
                                  .toString(),
                              snippet:
                                  "Située à ${controller.pharmacieDestination?.value.distance!.toStringAsFixed(2)} Km"),
                          icon: controller.mapMarker.value,
                          position: LatLng(
                              controller.pharmacieDestination!.value.latitude!,
                              controller
                                  .pharmacieDestination!.value.longitude!),
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
                                    controller.pharmaciesList.clear();
                                    await controller.getPharmacies(
                                        context: context);
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
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .pharmaciesList[index].nom!
                                                .toString()
                                                .capitalize!,
                                            style: const TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3,
                                            ),
                                          ),
                                          index == 0 &&
                                                  !controller
                                                      .searchForSomeBody.value
                                              ? const Text(
                                                  "(Plus près de vous)",
                                                  style: TextStyle(
                                                    color: kWhiteColor,
                                                    fontSize: 11,
                                                  ),
                                                )
                                              : Container(),
                                        ],
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
                                    Image.asset(
                                      "assets/images/pharmacy_two.png",
                                      fit: BoxFit.fill,
                                      height: 60,
                                      width: 50,
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tel: ${controller.pharmaciesList[index].phone!.toString()}",
                                          style: const TextStyle(
                                            color: kDarkColor,
                                            fontSize: 15,
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
                                            fontSize: 13,
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
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      controller.pharmaciesList[index]
                                                  .distance! >=
                                              0
                                          ? "Située à ${controller.pharmaciesList[index].distance!.toStringAsFixed(2)} Km de vous"
                                          : "",
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.all(0),
        child: Obx(
          () => Container(
            height: Get.height,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kDefaultPadding * 2),
                !controller.searchForSomeBody.value
                    ? Column(
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
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1.5,
                                  color: kTextColor2,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kDefaultRadius / 2),
                              ),
                              child: TextField(
                                controller: controller.textEditingDistance,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Rayon de recherche",
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 3,
                                        bottom: 8,
                                        right: 10)),
                              ),
                            ),
                          ])
                    : Container(),
                const SizedBox(height: kDefaultPadding),
                Row(children: [
                  Checkbox(
                      side: const BorderSide(width: 1, color: kTextColor2),
                      activeColor: kTextColor2,
                      value: controller.searchForSomeBody.value,
                      onChanged: (bool? val) {
                        controller.changeValue(val!);
                      }),
                  Text("Rechercher pour un proche ?",
                      style: TextStyle(
                          fontSize: 16, color: kDarkColor.withOpacity(.7))),
                ]),
                controller.searchForSomeBody.value == true
                    ? Column(children: [
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1.5,
                              color: kTextColor2,
                            ),
                            borderRadius:
                                BorderRadius.circular(kDefaultRadius / 2),
                          ),
                          child: TextField(
                            controller: controller.textEditingPays,
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Entrez le pays",
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 3, bottom: 8, right: 10)),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: kTextColor2,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(kDefaultRadius / 2),
                                ),
                                child: TextField(
                                  controller: controller.textEditingVille,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Entrez le ville",
                                      contentPadding: EdgeInsets.only(
                                          left: 10,
                                          top: 3,
                                          bottom: 8,
                                          right: 10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding),
                            Expanded(
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: kTextColor2,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(kDefaultRadius / 2),
                                ),
                                child: TextField(
                                  controller: controller.textEditingQuartier,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Entrez le quartier",
                                      contentPadding: EdgeInsets.only(
                                          left: 10,
                                          top: 3,
                                          bottom: 8,
                                          right: 10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ])
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        Get.back();
                        await controller.getPharmacies(context: context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        height: 40,
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
        ));
  }
}
