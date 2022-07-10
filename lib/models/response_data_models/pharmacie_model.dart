// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PharmacieRequestModel {
  final int? status;
  final bool? success;
  final String? message;
  final List<Pharmacie>? results;

  PharmacieRequestModel({
    this.status,
    this.success,
    this.message,
    this.results
  });

  factory PharmacieRequestModel.fromJson(String string) => PharmacieRequestModel.fromMap(json.decode(string));

  factory PharmacieRequestModel.fromMap(Map<String, dynamic> json) => PharmacieRequestModel(
    status: json['status'] ?? 0,
    success: json['success'] ?? false,
    message: json['message'] ?? "",
    results: json['results']  == null ? [] : List<Pharmacie>.from(json['results'].map((x) => Pharmacie.fromMap(x)))
  );


  Map<String, dynamic> toMap() => {
    'status': status,
    'success': success,
    'message': message,
    'results': results
  };

  String toJson() => json.encode(toMap());

}



class Pharmacie {
  final int? id;
  final String? nom;
  final String? localisation;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final DateTime? ouverture;
  final DateTime? fermeture;
  final int? user;
  final DateTime? created_at;
  final DateTime? updated_at;

  Pharmacie(
      {this.id,
      this.nom,
      this.localisation,
      this.phone,
      this.latitude,
      this.longitude,
      this.ouverture,
      this.fermeture,
      this.user,
      this.created_at,
      this.updated_at});

  factory Pharmacie.fromJson(String string) =>
      Pharmacie.fromMap(json.decode(string));

  factory Pharmacie.fromMap(Map<String, dynamic> json) => Pharmacie(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? "",
      localisation: json['localisation'] ?? "",
      phone: json['tel'] ?? "",
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
      ouverture: json['h_ouverture'] == null
          ? null
          : DateTime.parse(json['h_ouverture']),
      fermeture: json['h_fermeture'] == null
          ? null
          : DateTime.parse(json['h_fermeture']),
      user: json['user'] ?? 0,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at']),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']));

    Map<String, dynamic> toMap() => {
      'id': id,
      'nom': nom,
      'localisation': localisation,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'ouverture': ouverture,
      'fermeture': fermeture,
      'user': user,
      'created_at': created_at,
      'updated_at': updated_at
    };

    String toJson() => json.encode(toMap());
}