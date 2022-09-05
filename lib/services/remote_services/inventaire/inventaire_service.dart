

import 'package:pharmacy_app/models/response_data_models/inventaire_model.dart';

abstract class InventaireService {
  Future<void> findAll({
    String? url,
    String? idPharmacie,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
  Future<void> findOne({
    String? idInventaire,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> add({
    InventaireResponseModel? inventaireModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });

  Future<void> update({
    String? idInventaire,
    InventaireResponseModel? inventaireModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
}

