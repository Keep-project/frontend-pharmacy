

import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/utilisateur/utilisateur.dart';

class UtilisateurServiceImpl implements UtilisateurService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();
}