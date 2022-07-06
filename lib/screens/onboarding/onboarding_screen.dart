// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingScreenController> {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<OnboardingScreenController>(
          builder: (controller) => Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: Get.height - 24,
                    width: Get.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (int newIndex) {
                        controller.currentPageIndex = newIndex;
                        controller.update();
                      },
                      itemCount: controller.pages.length,
                      itemBuilder: (context, index) => controller.pages[index],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: kDefaultMargin * 2,
                    right: kDefaultMargin * 2,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(
                                controller.pages.length,
                                (index) => Container(
                                      height: 10,
                                      width:
                                          controller.currentPageIndex == index
                                              ? 25
                                              : 10,
                                      margin: const EdgeInsets.only(
                                          right: kDefaultMargin / 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius * 3),
                                        color:
                                            controller.currentPageIndex == index
                                                ? kTextColor2
                                                : kWhiteColor.withOpacity(.5),
                                      ),
                                    )),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (controller.currentPageIndex ==
                                  controller.pages.length - 1) {
                                controller.verifyToken();
                                return;
                              }
                              controller.onPressChangedPage();
                            },
                            child: Container(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              decoration: BoxDecoration(
                                  color: kTextColor2,
                                  borderRadius: BorderRadius.circular(
                                      kDefaultRadius * 4)),
                              child: Center(
                                child: Text(
                                  controller.currentPageIndex ==
                                          controller.pages.length - 1
                                      ? "Commencer"
                                      : "suivant",
                                  style: const TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
