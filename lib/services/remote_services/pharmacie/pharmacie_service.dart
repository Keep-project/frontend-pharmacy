import 'package:pharmacy_app/models/request_data_models/pharmacie_model.dart';

abstract class PharmacieService {
  Future<void> findAll({
    double? longitude,
    double? latitude,
    int? distance,
    String? search,
    String? pays,
    String? ville,
    String? quartier,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
  Future<void> findOne({
    String? idPharmacie,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> filter({
    String? search,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> add({
    PharmacieRequestModel? pharmacieModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> update({
    String? idPharmacie,
    PharmacieRequestModel? pharmacieModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> userPharmacies({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });


}
