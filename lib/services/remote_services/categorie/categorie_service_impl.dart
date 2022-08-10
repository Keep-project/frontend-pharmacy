import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/categorie_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/categorie/categorie.dart';

class CategorieServiceImpl implements CategorieService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  @override
  Future findAll(
      {Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/categorie/",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(CategorieRequestModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  
}
