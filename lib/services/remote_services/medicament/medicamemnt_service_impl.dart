
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class MedicamentServiceImpl implements MedicamentService {

  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

}