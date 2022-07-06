

// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

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
    return GetBuilder<MapViewScreenController>(
      
      builder: (controller) {
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
                mapType: MapType.normal,
                initialCameraPosition: controller.kGooglePlex,
                onMapCreated: (GoogleMapController control) {
                  controller.controller.complete(control);
                },
                
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding /2),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: kDefaultPadding /1.5),
                            GestureDetector(
                              onTap: () {Get.back();},
                              child: const Icon(CupertinoIcons.arrow_left, size: 26, color: kDarkColor)
                            ),
                            const SizedBox(width: kDefaultPadding /1.5,),
                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: kTextColor2,
                                  ),
                                  borderRadius: BorderRadius.circular(kDefaultRadius*3),
                                ),
                                child: TextField(
                                  controller: controller.textEditingControllerLocalisation,
                                  onChanged: (String value) {
                                      if ((value.toString().trim().isNotEmpty) &&
                                          (value.toString().trim() != controller.searchText)) {
                                        controller.autoCompleteSearch(value);
                                      } else {
                                        controller.predictions = [];
                                        controller.update();
                                      }
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon:  const Icon(Icons.room, color: Colors.red, size: 24),
                                      suffixIcon: GestureDetector(
                                        onTap: () async {
                                          await controller.clearLocation();
                                        },
                                        child: const Icon(Icons.close, color: kTextColor2)),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Localisation",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 8, bottom: 8, right: 10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding,),
                            const SizedBox(height: 16),
                            ...List.generate(
                                controller.predictions.length,
                                (ip) => GestureDetector(
                                      onTap: () async {
                                        unfocus();
                                        await controller.onSelectPlace(ip);
                                        //controller.changePageController();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                                horizontalTitleGap: 0,
                                                leading: const Icon(Icons.room, color: Colors.red, size: 36),
                                                title: Text(
                                                    '${controller.predictions[ip].description}',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        color: kDarkColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold))),
                                            controller.predictions.length - 1 != ip
                                                ? const Divider(
                                                    thickness: 2,
                                                  )
                                                : const Text(""),
                                          ],
                                        ),
                                      ),
                                    )),
                           
                          ],
                        ),
                       
                      ],
                    ),
                  ),
              ),
              ],
            ),
          ),
        );
      }
    );
  }
}


