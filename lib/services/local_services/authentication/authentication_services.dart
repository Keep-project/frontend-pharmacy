
abstract class LocalAuthentificationService {
  Future<bool> saveToken(String token);
  Future<void> saveUser(String user);
  Future<String?> getUser();
  Future<bool> deleteUser();
  Future<String?> getToken();
  Future<bool> deleteToken();
  Future<bool> hasAuthToken();
}