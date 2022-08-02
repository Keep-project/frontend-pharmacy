import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/medicament/medicament.dart';

class MedicamentServiceImpl implements MedicamentService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future medicamentsList(
      {String? url,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/medicament",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(MedicamentRequestModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future getMedicamentsById(
      {String? idMedicament,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/medicament/$idMedicament",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(Medicament.fromMap(data['results']));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
