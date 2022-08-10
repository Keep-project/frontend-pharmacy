

import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';

abstract class EntrepotService {
  Future<void> findAll({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
  Future<void> findOne({
    String? idEntrepot,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> add({
    EntrepotResponseModel? entrepotModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> update({
    String? idEntrepot,
    EntrepotResponseModel? entrepotModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
}