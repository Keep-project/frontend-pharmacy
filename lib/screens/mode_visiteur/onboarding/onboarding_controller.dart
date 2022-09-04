

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_visiteur/onboarding/onboarding_views/onboarding_one.dart';
import 'package:pharmacy_app/screens/mode_visiteur/onboarding/onboarding_views/onboarding_three.dart';
import 'package:pharmacy_app/screens/mode_visiteur/onboarding/onboarding_views/onboarding_two.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';

class OnboardingScreenController extends GetxController {

  final PageController pageController = PageController();
  int currentPageIndex = 0;

  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

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

  Future verifyToken() async{
    if ( await _localAuth.hasAuthToken()){
      Future.delayed(const Duration(milliseconds: 800), () {
        //Get.offAllNamed(AppRoutes.LOGIN);
        Get.offAllNamed(AppRoutes.STARTPAGE);
      });
    }
    else{
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  @override
  void onInit() async {
    await verifyToken();
    super.onInit();
  }

  void onPressChangedPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

 

}