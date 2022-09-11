
import 'package:pharmacy_app/models/request_data_models/medicament_model.dart';

abstract class MedicamentService {
  Future medicamentsList({
    String? url,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future medicamentsForEntrepot({
    String? url,
    String? idEntrepot,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future filterList({
    dynamic data,
    String? url,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future medicamentForPharmacy({
    dynamic data,
    String? url,
    String? idPharmacie,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future getMedicamentsById({
    String? idMedicament,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future add({
    MedicamentRequestModel? medicamentModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future<void> update({
    String? idMedicament,
    MedicamentRequestModel? medicamentModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
}