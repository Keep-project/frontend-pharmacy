abstract class LocalAuthentificationService {
  Future<bool> saveToken(String token);
  // Future<bool> hasAuthenticate();
  Future<String?> getToken();
  Future<bool> deleteToken();
  // Future<bool> saveUser(dynamic user);
  // Future<dynamic> getUser();
  // Future<bool> deleteUser();
}