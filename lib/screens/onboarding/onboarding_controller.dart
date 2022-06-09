

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding_views/onboarding_three.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding_views/onboarding_two.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding_views/onboarding_one.dart';

class OnboardingScreenController extends GetxController {

  final PageController pageController = PageController();
  int currentPageIndex = 0;

  final List<Widget> pages = <Widget>[
    const OnboardingOne(),
    const OnboardingTwo(),
    const OnboardingThree(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPressChangedPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }
}