
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/home/home.dart';

class HomeScreenBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}