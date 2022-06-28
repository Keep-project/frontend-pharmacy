


import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/request_data_models/login_model.dart';
import 'package:pharmacy_app/models/request_data_models/register_model.dart';
import 'package:pharmacy_app/models/response_data_models/token_model.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication_service.dart';

class RemoteAuthenticationServiceImpl implements RemoteAuthenticationService {


  @override
  Future<void> login({
    LoginRequestModel? loginReqModel,
    Function(dynamic data)? onLoginSuccess,
    Function(dynamic error)? onLoginError}) async {

      ApiRequest(
        url: "${Constants.API_URL}/jwt/create",
        // data: <String, String>{"username": "$login","password": "$password"},
        data: loginReqModel!.toMap(),
      ).post(
        onSuccess: (data){
          onLoginSuccess!(TokenReponseModel.fromMap(data));
        },
        onError: (error){
          if (error != null) { onLoginError!(error);}
        }
      );
    
  }

  @override
  Future<void> register({
    RegisterRequestModel? registerReqModel,
    Function(dynamic data)? onRegisterSuccess,
    Function(dynamic error)? onRegisterError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/",
      data: registerReqModel!.toMap(),
    ).post(
       onSuccess: (data){
          onRegisterSuccess!(data);
        },
        onError: (error){
          if (error != null) { onRegisterError!(error);}
        }
    );
  } 

}