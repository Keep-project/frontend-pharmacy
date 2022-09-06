abstract class MouvementStockService {
  Future mouvementStockForPharmacy({
    String? url,
    String? idPharmacie,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });
  Future mouvementStockForProduct({
    String? url,
    String? idMedicament,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

}