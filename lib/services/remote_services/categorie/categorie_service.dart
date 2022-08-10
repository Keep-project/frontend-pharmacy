

abstract class CategorieService {

  Future<void> findAll({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  });
}