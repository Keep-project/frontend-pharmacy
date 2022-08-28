import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/pharmacie_form/pharmacie_form.dart';

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
                  children: [
                    Container(
                      height: Get.height * 0.55,
                      width: double.infinity,
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
                          //await controller.onCameraIdle();
                        },

                        // markers: {
                        //   controller.currentLocation != null
                        //       ? Marker(
                        //           markerId: const MarkerId("point-id-0"),
                        //           infoWindow: const InfoWindow(
                        //               title: "Current location",
                        //               snippet: "Ma position actuelle"),
                        //           icon: controller.mapMarker.value,
                        //           position: LatLng(
                        //               controller.currentLocation!.latitude!,
                        //               controller.currentLocation!.longitude!),
                        //         )
                        //       : const Marker(
                        //           markerId: MarkerId("point-id-2"),
                        //         ),
                        // },
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(children: [
                    const SizedBox(height: kDefaultPadding * 1.2),
                    CustomTextField2(
                      onChanged: (string) {},
                      title: "Pays",
                      hintText: "Ex: Cameroun",
                    ),
                    const SizedBox(height: kDefaultPadding / 1.4),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField2(
                            onChanged: (string) {},
                            title: "Ville",
                            hintText: "Ex: 150",
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        Expanded(
                          child: CustomTextField2(
                            onChanged: (string) {},
                            title: "Quartier",
                            hintText: "Ex: 400",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.previousPage();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                border: Border.all(
                                  width: 1,
                                  color: kTextColor2,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kDefaultRadius - 2),
                              ),
                              child: const Center(
                                child: Text(
                                  "Retour",
                                  style: TextStyle(
                                    color: kTextColor2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (controller.step == 2) {
                                //controller.jumpToStepThree(context);
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: kTextColor2,
                                borderRadius:
                                    BorderRadius.circular(kDefaultRadius - 2),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Enregistrer",
                                      style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: kDefaultPadding),
                                    Icon(CupertinoIcons.arrow_right,
                                        color: kWhiteColor, size: 26),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ],
            ));
  }
}

class CustomIconButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;
  const CustomIconButton({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: kTextColor2.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(kDefaultRadius - 2),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: kDarkColor.withOpacity(0.5),
                ),
              ),
              const Spacer(),
              Icon(iconData, color: kDarkColor.withOpacity(0.3), size: 26),
            ],
          )),
    );
  }
}
