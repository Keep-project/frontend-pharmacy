

import 'package:get/get.dart';
import 'package:pharmacy_app/screens/login/login.dart';

class  LoginScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
  }
}