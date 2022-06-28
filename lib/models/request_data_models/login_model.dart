
class LoginRequestModel{
  LoginRequestModel({
    this.username, this.password
  });
  final String? username;
  final String? password;
  
  Map<String, String> toMap() => {
    'username': username ?? "",
    'password': password ?? "",
  };
}