

class RegisterRequestModel {
  RegisterRequestModel({this.username, this.password, this.email, this.avatar});

  final String ? username ;
  final String ? password;
  final String ? email ;
  final String ? avatar ;

  Map<String, String> toMap() => {
      'username': username ?? '',
      'password': password ?? '',
      'email': email ?? '',
      'avatar': avatar ?? ''
  };


}