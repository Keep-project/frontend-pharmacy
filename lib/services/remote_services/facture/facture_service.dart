

import 'package:pharmacy_app/models/response_data_models/facture_model.dart';

abstract class FactureService {
  Future<void> findAll({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
  Future<void> findOne({
    String? idFacture,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> add({
    FactureResponseModel? factureModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> update({
    String? idFacture,
    FactureResponseModel? factureModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
}