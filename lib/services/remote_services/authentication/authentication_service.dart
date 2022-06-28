

import 'package:pharmacy_app/models/request_data_models/login_model.dart';
import 'package:pharmacy_app/models/request_data_models/register_model.dart';

abstract class RemoteAuthenticationService {
  Future<void> login({
    LoginRequestModel? loginReqModel,
    Function(dynamic data)? onLoginSuccess,
    Function(dynamic error)? onLoginError,
  });

  Future<void> register({
    RegisterRequestModel? registerReqModel,
    Function(dynamic data)? onRegisterSuccess,
    Function(dynamic error)? onRegisterError,
  });
}