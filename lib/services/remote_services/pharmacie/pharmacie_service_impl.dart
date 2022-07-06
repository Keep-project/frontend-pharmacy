

// ignore_for_file: unused_field

import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class PharmacieServiceImpl implements PharmacieService {

  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();
}