

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding_controller.dart';


class OnboardingScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OnboardingScreenController>(() => OnboardingScreenController());
  }
}