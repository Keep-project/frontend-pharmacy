

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_visiteur/onboarding/onboarding.dart';


class OnboardingScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OnboardingScreenController>(() => OnboardingScreenController());
  }
}