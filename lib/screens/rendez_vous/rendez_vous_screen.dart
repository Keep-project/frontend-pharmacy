// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/search_bar.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/rendez_vous/components/doctor_card.dart';
import 'package:pharmacy_app/screens/rendez_vous/components/speciality_card.dart';
import 'package:pharmacy_app/screens/rendez_vous/rendez_vous.dart';

class RendezVousScreen extends GetView<RendezVousScreenController> {
  const RendezVousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<RendezVousScreenController>(builder: (controller) {
          return Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kDefaultPadding * 1.5,
                  ),
                  SearchBar(controller: controller.searchController, onTap: () {print("Search");}),
                  const SizedBox(height: kDefaultMargin * 2),
                  const TitleText(title: "Catégories"),
                  const SizedBox(height: kDefaultMargin * 1.5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        SpecialityCard(
                            assetName: "assets/images/icon-dentist.svg",
                            title: "Dentiste",
                            number: 03),
                        SpecialityCard(
                            assetName: "assets/images/icon-brain.svg",
                            title: "Cerveau",
                            number: 05),
                        SpecialityCard(
                          assetName: "assets/images/icon-heart.svg",
                          title: "Coeur",
                          number: 08,
                        ),
                        SpecialityCard(
                          assetName: "assets/images/icon-bone.svg",
                          title: "Os",
                          number: 04,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultMargin * 2),
                  Row(
                    children: [
                      const TitleText(title: "Nos docteurs"),
                      const Spacer(),
                      Text(
                        "Voir plus",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(.4),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultMargin * 1.5),
                  ...List.generate(
                    5,
                    (index) => const DoctorCard(),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: const Padding(
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: Icon(Icons.menu, size: 30, color: kWhiteColor),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.DASHBORD);
          },
          child: Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: kDefaultMargin * 2),
            decoration: BoxDecoration(
              color: kGreyColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: Icon(CupertinoIcons.person_fill,
                    size: 30, color: kWhiteColor)),
          ),
        ),
      ],
    );
  }
}



