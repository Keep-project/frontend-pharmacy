import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/facture_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/facture/facture_service.dart';

class FactureServiceImpl implements FactureService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future<void> add(
      {dynamic data,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/facture/",
      data: data!,
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
  Future findAll(
    {
      String? url,
      String? idPharmacie,  
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/facture/me/$idPharmacie",
      data: {},
      token: await _localAuth.getToken(),
    ).post(onSuccess: (data) {
      onSuccess!(FactureResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> findOne(
      {String? idFacture,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError})  async {
     ApiRequest(
      url: "${Constants.API_URL}/facture/$idFacture",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(FactureResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> update(
      {String? idFacture,
      FactureResponseModel? factureModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
     ApiRequest(
      url: "${Constants.API_URL}/facture/$idFacture",
      data: factureModel!.toMap(),
    ).put(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
