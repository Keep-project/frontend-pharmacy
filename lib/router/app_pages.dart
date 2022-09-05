

import 'package:get/get.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/dashbord/dashbord.dart';
import 'package:pharmacy_app/screens/login/login.dart';
import 'package:pharmacy_app/screens/mode_gestion/detail_entrepot/detail_entrepot.dart';
import 'package:pharmacy_app/screens/mode_gestion/detail_facture/detail_facture.dart';
import 'package:pharmacy_app/screens/mode_gestion/detail_inventaire/detail_inventaire.dart';
import 'package:pharmacy_app/screens/mode_gestion/entrepot/entrepot.dart';
import 'package:pharmacy_app/screens/mode_gestion/entrepot_form/entrepot_form.dart';
import 'package:pharmacy_app/screens/mode_gestion/facture_form/facture_form.dart';
import 'package:pharmacy_app/screens/mode_gestion/factures/factures.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire/inventaire.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire_form/inventaire_form.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/medicament_form.dart';
import 'package:pharmacy_app/screens/mode_gestion/mouvement_produit/mouvement_produit.dart';
import 'package:pharmacy_app/screens/mode_gestion/mouvement_stock/mouvement_stock.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie/pharmacie.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pharmacie_form.dart';
import 'package:pharmacy_app/screens/mode_gestion/stocks/stock.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/home.dart';
import 'package:pharmacy_app/screens/mode_visiteur/mapview/mapview.dart';
import 'package:pharmacy_app/screens/mode_visiteur/medicaments/medicaments.dart';
import 'package:pharmacy_app/screens/mode_visiteur/onboarding/onboarding.dart';
import 'package:pharmacy_app/screens/mode_visiteur/visiteur_details/details.dart';
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
      page: () => const DetailVisteurScreen(),
      binding: DetailVisiteurScreenBinding(),
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
      binding: MedicamentFormBinding(),
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
    GetPage(
      name: AppRoutes.STOCK,
      page: () => const StockScreen(),
      binding: StockBinding(),
    ),
    GetPage(
      name: AppRoutes.MOUVEMENT_PRODUIT,
      page: () => const MouvementMedicamentScreen(),
      binding: MouvementMedicamentBinding(),
    ),
    GetPage(
      name: AppRoutes.MOUVEMENT_STOCK,
      page: () => const MouvementStockScreen(),
      binding: MouvementStockBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_ENTREPOT,
      page: () => const DetailEntrepotScreen(),
      binding: DetailEntrepotBinding(),
    ),
    GetPage(
      name: AppRoutes.ENTREPOT,
      page: () => const EntrepotScreen(),
      binding: EntrepotBinding(),
    ),
    GetPage(
      name: AppRoutes.ENTREPOT_FORM,
      page: () => const EntrepotFormScreen(),
      binding: EntrepotFormBinding(),
    ),
    GetPage(
      name: AppRoutes.INVENTAIRES,
      page: () => const InventaireScreen(),
      binding: InventaireBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_INVENTAIRES,
      page: () => const DetailInventaireScreen(),
      binding: DetailInventaireBinding(),
    ),
    GetPage(
      name: AppRoutes.FACTURES,
      page: () => const FactureScreen(),
      binding: FactureBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_FACTURES,
      page: () => const DetailFactureScreen(),
      binding: DetailFactureBinding(),
    ),
    GetPage(
      name: AppRoutes.FACTURES_FORM,
      page: () => const FactureFormScreen(),
      binding: FactureFormBinding(),
    ),
    GetPage(
      name: AppRoutes.INVENTAIRES_FORM,
      page: () => const InventaireFormScreen(),
      binding: InventaireFormBinding(),
    ),

    GetPage(
      name: AppRoutes.PHARMACIE_USER,
      page: () => const PharmacieScreen(),
      binding: PharmacieScreenBinding(),
    ),
  ]; 
}