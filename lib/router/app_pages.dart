

import 'package:get/get.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/dashbord/dashbord.dart';
import 'package:pharmacy_app/screens/details/details.dart';
import 'package:pharmacy_app/screens/home/home.dart';
import 'package:pharmacy_app/screens/login/login.dart';
import 'package:pharmacy_app/screens/mapview/mapview.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form.dart';
import 'package:pharmacy_app/screens/medicaments/medicaments.dart';
import 'package:pharmacy_app/screens/onboarding/onboarding.dart';
import 'package:pharmacy_app/screens/pharmacie_form/pharmacie_form.dart';
import 'package:pharmacy_app/screens/register/register.dart';
import 'package:pharmacy_app/screens/rendez_vous/rendez_vous.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/rendez_vous_details.dart';
import 'package:pharmacy_app/screens/start/start.dart';

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
      name: AppRoutes.STARTPAGE,
      page: () => const StartScreen(),
      binding: StartScreenBinding(),
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
    GetPage(
      name: AppRoutes.MEDICAMENTS,
      page: () => const MedicamentScreen(),
      binding: MedicamentScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.MAPVIEW,
      page: () => const MapViewScreen(),
      binding: MapViewScreenBinding(),
    ),

     GetPage(
      name: AppRoutes.MEDICAMENTSFORM,
      page: () => const MedicamentFormScreen(),
      binding: MedicamentFormScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.PHARMACIEFORM,
      page: () => const PharmacieFormScreen(),
      binding: PharmacieFormScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: OnboardingScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.DASHBORD,
      page: () => const DashbordScreen(),
      binding: DashbordScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.RENDEZVOUS,
      page: () => const RendezVousScreen(),
      binding: RendezVousScreenBinding(),
    ),

    GetPage(
      name: AppRoutes.RENDEZVOUSDETAILS,
      page: () => const RendezVousScreenDetails(),
      binding: RendezVousScreenDetailsBinding(),
    ),
  ]; 
}