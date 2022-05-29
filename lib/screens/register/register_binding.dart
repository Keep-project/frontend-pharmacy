import 'package:get/get.dart';
import 'package:pharmacy_app/screens/register/register.dart';

class  RegisterScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}