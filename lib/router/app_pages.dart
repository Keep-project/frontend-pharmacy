

import 'package:get/get.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/details/details.dart';
import 'package:pharmacy_app/screens/details/details_screen.dart';
import 'package:pharmacy_app/screens/home/home.dart';
import 'package:pharmacy_app/screens/login/login.dart';
import 'package:pharmacy_app/screens/register/register.dart';

class AppPages {
  
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding()
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterScreenBinding()
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.DETAILS,
      page: () => const DetailScreen(),
      binding: DetailScreenBinding(),
    ),

  ]; 
}