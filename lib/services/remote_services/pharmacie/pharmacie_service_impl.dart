// ignore_for_file: unused_field

import 'package:pharmacy_app/core/api_library.dart';
import 'package:pharmacy_app/core/constants.dart';
import 'package:pharmacy_app/models/request_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/pharmacie/pharmacie.dart';

class PharmacieServiceImpl implements PharmacieService {
  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  // Méthode permettant de rechercher une pharmacie par son id
  @override
  Future findOne(
      {String? idPharmacie,
      Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/pharmacie/$idPharmacie",
      data: {},
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(PharmacieResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future findAll(
      {Function(dynamic data)? onSuccess,
      Function(dynamic date)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/pharmacie/",
      token: await _localAuth.getToken(),
    ).get(onSuccess: (data) {
      onSuccess!(PharmacieResponseModel.fromMap(data));
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }

  @override
  Future<void> add(
      {PharmacieRequestModel? pharmacieModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/pharmacie/",
      data: pharmacieModel!.toMap(),
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
      {String? idPharmacie,
      PharmacieRequestModel? pharmacieModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/pharmacie/$idPharmacie",
      data: pharmacieModel!.toMap(),
    ).put(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
