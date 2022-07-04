

abstract class UtilisateurService{
  Future<void> getUser({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,}
  );
}