import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/request_data_models/medicament_model.dart';
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
      url: url ?? "${Constants.API_URL}/medicament/",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(MedicamentResponseModel.fromMap(data));
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

  @override
  Future<void> add(
      {MedicamentRequestModel? medicamentModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/medicament/",
      data: medicamentModel!.toMap(),
      token: await _localAuth.getToken(),
    ).post(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> update(
      {String? idMedicament,
      MedicamentRequestModel? medicamentModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/pharmacie/$idMedicament",
      data: medicamentModel!.toMap(),
      token: await _localAuth.getToken(),
    ).put(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future filterList(
      {data,
      String? url,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/medicament/filter/",
      data: data,
      token: await _localAuth.getToken(),
    ).post(onSuccess: (data) {
      onSuccess!(MedicamentResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future medicamentForPharmacy(
      {data,
      String? url,
      String? idPharmacie,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/medicament/me/$idPharmacie",
      data: data,
      token: await _localAuth.getToken(),
    ).post(onSuccess: (data) {
      onSuccess!(MedicamentResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
  
  @override
  Future medicamentsForEntrepot({
    String? url,
    String? idEntrepot,
    Function(dynamic data)?
    onSuccess,
    Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/entrepot/medecine/$idEntrepot/list",
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(MedicamentResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
