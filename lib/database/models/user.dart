import 'dart:convert';

const String tableUser = "users";

class UserFields {
  static const List<String> values = [
    id,
    password,
    lastLogin,
    isSuperuser,
    username,
    firstName,
    lastName,
    email,
    isStaff,
    isActive,
    dateJoined,
    adresse,
    avatar,
    status,
    experience,
    isUpdate
  ];

  static const String id = "_id";
  static const String password = "password";
  static const String lastLogin = "last_login";
  static const String isSuperuser = "is_superuser";
  static const String username = "username";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String email = "email";
  static const String isStaff = "is_staff";
  static const String isActive = "is_active";
  static const String dateJoined = "date_joined";
  static const String adresse = "adresse";
  static const String avatar = "avatar";
  static const String status = "status";
  static const String experience = "experience";
  static const String isUpdate = "isUpdate";
}

class User {
  final int? id;
  final String? password;
  final DateTime? lastLogin;
  final bool? isSuperuser;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isStaff;
  final bool? isActive;
  final DateTime? dateJoined;
  final String? adresse;
  final String? avatar;
  final String? status;
  final String? experience;
  final bool? isUpdate;

  User(
      {this.id,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.adresse,
      this.avatar,
      this.status,
      this.experience,
      this.isUpdate});

  factory User.formJson(String string) => User.fromMap(json.decode(string));

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json[UserFields.id] as int?,
        password: json[UserFields.password] as String,
        lastLogin: DateTime.parse(json[UserFields.lastLogin] as String),
        isSuperuser: json[UserFields.isSuperuser] == 1 ? true : false,
        username: json[UserFields.username] as String,
        firstName: json[UserFields.firstName] as String,
        lastName: json[UserFields.lastName] as String,
        email: json[UserFields.email] as String,
        isStaff: json[UserFields.isStaff] == 1 ? true : false,
        isActive: json[UserFields.isActive] == 1 ? true : false,
        dateJoined: DateTime.parse(json[UserFields.dateJoined] as String),
        adresse: json[UserFields.adresse] as String?,
        avatar: json[UserFields.avatar] as String?,
        status: json[UserFields.status] as String?,
        experience: json[UserFields.experience] as String?,
        isUpdate:  json[UserFields.isUpdate] == 1 ? true : false
      );

  Map<String, dynamic> toMap() => {
        UserFields.id: id,
        UserFields.password: password,
        UserFields.lastLogin: lastLogin!.toIso8601String(),
        UserFields.isSuperuser: isSuperuser == true ? 1 : 0,
        UserFields.username: username,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.email: email,
        UserFields.isStaff: isStaff == true ? 1 : 0,
        UserFields.isActive: isActive == true ? 1 : 0,
        UserFields.dateJoined: dateJoined!.toIso8601String(),
        UserFields.adresse: adresse,
        UserFields.avatar: avatar,
        UserFields.status: status,
        UserFields.experience: experience,
        UserFields.isUpdate: isUpdate == true ? 1 : 0
      };

  User copy({
    int? id,
    String? password,
    DateTime? lastLogin,
    bool? isSuperuser,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    bool? isStaff,
    bool? isActive,
    DateTime? dateJoined,
    String? adresse,
    String? avatar,
    String? status,
    String? experience,
    bool? isUpdate
  }) =>
      User(
        id: id ?? this.id,
        password: password ?? this.password,
        lastLogin: lastLogin ?? this.lastLogin,
        isSuperuser: isSuperuser ?? this.isSuperuser,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        isStaff: isStaff ?? this.isStaff,
        isActive: isActive ?? this.isActive,
        dateJoined: dateJoined ?? this.dateJoined,
        adresse: adresse ?? this.adresse,
        avatar: avatar ?? this.avatar,
        status: status ?? this.status,
        experience: experience ?? this.experience,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
