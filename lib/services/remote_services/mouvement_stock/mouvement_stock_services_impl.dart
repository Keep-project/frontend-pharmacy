import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/mouvement_stock_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/mouvement_stock/mouvement_stock.dart';

class MouvementStockServiceImpl implements MouvementStockService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future mouvementStockForPharmacy(
      {String? url,
      String? idPharmacie,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/mouvement/pharmacy/$idPharmacie",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(MouvementStockResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future mouvementStockForProduct(
      {String? url,
      String? idMedicament,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: url ?? "${Constants.API_URL}/mouvement/medecine/$idMedicament",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(MouvementStockResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
