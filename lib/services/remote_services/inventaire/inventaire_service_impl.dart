import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/models/response_data_models/inventaire_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/inventaire/inventaire.dart';

class InventaireServiceImpl implements InventaireService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future<void> add(
      {dynamic data,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/inventaire/",
      token: await _localAuth.getToken(),
      data: data!,
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
      url: url ?? "${Constants.API_URL}/inventaire/me/$idPharmacie",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(InventaireResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> findOne(
      {String? idInventaire,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError})  async {
     ApiRequest(
      url: "${Constants.API_URL}/inventaire/$idInventaire",
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
      {String? idInventaire,
    InventaireResponseModel? inventaireModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
     ApiRequest(
      url: "${Constants.API_URL}/inventaire/$idInventaire",
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
