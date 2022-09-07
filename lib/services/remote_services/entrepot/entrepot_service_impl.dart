import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/entrepot/entrepot.dart';

class EntrepotServiceImpl implements EntrepotService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future<void> add(
      {EntrepotResponseModel? entrepotModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/entrepot/",
      // data: entrepotModel!.toMap(),
    ).post(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future findAll({
    String? url,
    String? idPharmacie,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/entrepot/pharmacy/$idPharmacie",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(EntrepotResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> findOne(
      {String? idEntrepot,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError})  async {
     ApiRequest(
      url: "${Constants.API_URL}/entrepot/$idEntrepot",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(EntrepotResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> update(
      {String? idEntrepot,
      EntrepotResponseModel? entrepotModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
     ApiRequest(
      url: "${Constants.API_URL}/entrepot/$idEntrepot",
      // data: factureModel!.toMap(),
    ).put(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    }
    
    );
  }
}
