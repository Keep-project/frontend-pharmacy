

import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/response_data_models/user_data.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/utilisateur/utilisateur.dart';

class UtilisateurServiceImpl implements UtilisateurService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();


  @override
  Future<void> getUser(
      {Function(dynamic data)? onSuccess, Function(dynamic error)? onError}) async {
        ApiRequest(
          url: "${Constants.API_URL}/book/utilisateur/info/",
          data: {},
          token: await _localAuth.getToken(),
        ).get(
          onSuccess: (data){
            onSuccess!(UserResponseModel.fromMap(data));
          },
          onError: (error){
            if ( error != null){
              onError!(error);
            }
          }
        );
  }
}