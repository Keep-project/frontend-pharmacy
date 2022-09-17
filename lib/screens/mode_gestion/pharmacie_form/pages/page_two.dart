// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pharmacie_form.dart';

class PageTwo extends GetView<PharmacieFormScreenController> {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GetBuilder<PharmacieFormScreenController>(
        builder: (controller) => Column(
              children: [
                Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Container(
                      height: Get.height-24,
                      width: Get.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: GoogleMap(
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
                          try{
                            await controller.onCameraIdle();
                          }
                          catch(e){
                            print(e);
                          }
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId("point-id-0"),
                            infoWindow: InfoWindow(
                                title: "Localisation actuelle",
                                snippet: controller.localisationInformations != null ? controller.localisationInformations!.country! : "Yoaundé" ),
                            icon: controller.mapMarker.value,
                            position: LatLng(controller.position.latitude,
                                controller.position.longitude),
                          )
                        },
                      ),
                    ),
                    Positioned(
                      bottom: kDefaultPadding,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      child: Container(
                        width: Get.width,
                        decoration: const BoxDecoration(),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {controller.previousPage();},
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: const BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_left, color: kDarkColor, size: 36 )),
                            ),
                              const Spacer(),
                              InkWell(
                                onTap: () { controller.nextPage(); },
                                child: Container(
                                height: 45,
                                width: 45,
                                decoration: const BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_right, color: kDarkColor, size: 36 )),
                              ),
                            ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: kDefaultPadding / 2,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
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
                            controller:
                                controller.textEditingControllerLocalisation,
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
                                    left: 10, top: 8, bottom: 8, right: 10)),
                          ),
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
                                height: Get.height * 0.4,
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
                                                  leading: const Icon(
                                                      Icons.room,
                                                      color: kOrangeColor,
                                                      size: kDefaultPadding),
                                                  title: Text(
                                                      '${controller.predictions[ip].description}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          color: kDarkColor,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              controller.predictions.length -
                                                          1 !=
                                                      ip
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
                        : Container(),
                  ],
                ),
              ],
            ));
  }
}
