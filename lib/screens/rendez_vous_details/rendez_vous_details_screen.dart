// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/components/day_card.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/components/header_card.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/rendez_vous_details.dart';

class RendezVousScreenDetails
    extends GetView<RendezVousScreenControllerDetails> {
  const RendezVousScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<RendezVousScreenControllerDetails>(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderCard(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kDefaultPadding),
                        TitleText(title: controller.dateName),
                        const SizedBox(height: kDefaultMargin * 1.5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  controller.dayList.length,
                                  (index) =>
                                      DayCard(index: index, controller: controller))),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Row(
                          children: [
                            const TitleText(title: "Matinée "),
                            Container(
                              decoration: const BoxDecoration(),
                              child: SvgPicture.asset(
                                  "assets/images/icon-sunny.svg"),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Wrap(
                          spacing: (Get.width -
                                  Get.width * 3 / 3.5 -
                                  kDefaultPadding * 2) /
                              2.1,
                          runSpacing: kDefaultMargin,
                          children: [
                            Container(
                              width: Get.width / 3.5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: kTextColor2,
                                borderRadius:
                                    BorderRadius.circular(kDefaultMargin - 2),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.timer,
                                      color: kWhiteColor.withOpacity(0.8),
                                      size: 24),
                                  const SizedBox(width: 3),
                                  Text(
                                    "08h00-08h30",
                                    style: TextStyle(
                                      color: kWhiteColor.withOpacity(0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                          ],
                        ),
                        const SizedBox(height: kDefaultMargin * 1.5),
                        Row(
                          children: [
                            const TitleText(title: "Soirée "),
                            Container(
                              decoration: const BoxDecoration(),
                              child: SvgPicture.asset(
                                  "assets/images/icon-sunny.svg"),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Wrap(
                          spacing: (Get.width -
                                  Get.width * 3 / 3.5 -
                                  kDefaultPadding * 2) /
                              2.1,
                          runSpacing: kDefaultMargin,
                          children: [
                            const FreeHour(),
                            const FreeHour(),
                            Container(
                              width: Get.width / 3.5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: kTextColor2,
                                borderRadius:
                                    BorderRadius.circular(kDefaultMargin - 2),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.timer,
                                      color: kWhiteColor.withOpacity(0.8),
                                      size: 24),
                                  const SizedBox(width: 3),
                                  Text(
                                    "08h00-08h30",
                                    style: TextStyle(
                                      color: kWhiteColor.withOpacity(0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                            const FreeHour(),
                          ],
                        ),
                        const SizedBox(height: kDefaultMargin * 4),
                        GestureDetector(
                          onTap: () {
                            print("Pendre un rendez-vous");
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: kTextColor2,
                                  borderRadius: BorderRadius.circular(
                                      kDefaultRadius - 2)),
                              child: const Center(
                                  child: Text(
                                "Prendre un rendez-vous",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ))),
                        ),
                        const SizedBox(height: kDefaultMargin * 2),
                      ],
                    ),
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
      leading: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left,
                size: 30, color: kWhiteColor)),
      ),
    );
  }
}

class FreeHour extends StatelessWidget {
  const FreeHour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3.5,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kTextColor2.withOpacity(0.08),
        borderRadius: BorderRadius.circular(kDefaultMargin - 2),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: kDarkColor.withOpacity(0.5), size: 24),
          const SizedBox(width: 3),
          Text(
            "08h00-08h30",
            style: TextStyle(
              color: kDarkColor.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
