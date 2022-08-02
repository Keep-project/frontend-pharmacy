
abstract class MedicamentService {
  Future medicamentsList({
    String? url,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future getMedicamentsById({
    String? idMedicament,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });
}