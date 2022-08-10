import 'dart:convert';

class UserResponseModel {
  final bool? success;
  final String? message;
  final User? results;

  UserResponseModel({this.success, this.message, this.results});

  factory UserResponseModel.fromJson(String string) => UserResponseModel.fromMap(json.decode(string));

  factory UserResponseModel.fromMap(Map<String, dynamic> json) => UserResponseModel(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    results: json['results'] == null ? null : User.fromMap(json['results']),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "results": results
  };

  String toJson() => json.encode(toMap());
}

class User {
  
  User(
      {this.id,
      this.username,
      this.avatar,
      this.email,
      this.dateJoined,
      this.userPermissions,
    }
    );


  final int? id;
  final String? username;
  final String? avatar;
  final String? email;
  final DateTime? dateJoined;
  final List<String>? userPermissions;



  factory User.fromJson(String string) => User.fromMap(json.decode(string));

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    username: json['username'] ?? "",
    avatar: json['get_avatar_url'] ?? "",
    email: json['email'] ?? "",
    dateJoined: json['date_joined'] == null ? null: DateTime.parse(json['date_joined']),
    userPermissions: json['user_permissions'] == null ? [] : List<String>.from(json['user_permissions'].map((e) => e)),
  );

  Map<String, dynamic> toMap() => {
    'id': id ?? 0,
    'username': username ?? "",
    'avatar': avatar ?? "",
    'email': email ?? "",
    'dateJoined': dateJoined == null ? DateTime.now().toIso8601String() : dateJoined!.toIso8601String(),
    'userPermissions': userPermissions ?? [],
  };

  String toJson() => json.encode(toMap());
}
