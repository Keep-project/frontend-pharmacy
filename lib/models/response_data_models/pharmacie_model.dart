// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';

class PharmacieResponseModel {
  final int? status;
  final bool? success;
  final String? message;
  final List<Pharmacie>? results;

  PharmacieResponseModel({
    this.status,
    this.success,
    this.message,
    this.results
  });

  factory PharmacieResponseModel.fromJson(String string) => PharmacieResponseModel.fromMap(json.decode(string));

  factory PharmacieResponseModel.fromMap(Map<String, dynamic> json) => PharmacieResponseModel(
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
  final String? email;
  final int? stock;
  final double? latitude;
  final double? longitude;
  final String? ouverture;
  final String? fermeture;
  final int? user;
  final DateTime? created_at;
  final DateTime? updated_at;

  Pharmacie(
      {this.id,
      this.nom,
      this.localisation,
      this.phone,
      this.email,
      this.stock,
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
      email: json['email'] ?? "",
      stock: json['stock'] ?? 0,
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
      ouverture: json['h_ouverture'] ?? "08:00 AM",
      fermeture: json['h_fermeture'] ?? "20:00 AM",
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
      'email': email,
      'stock': stock,
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
