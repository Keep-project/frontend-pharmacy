// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacy_app/database/models/pharmacie.dart' as lp;

class PharmacieResponseModel {
  final int? status;
  final bool? success;
  final String? message;
  final List<Pharmacie>? results;

  PharmacieResponseModel(
      {this.status, this.success, this.message, this.results});

  factory PharmacieResponseModel.fromJson(String string) =>
      PharmacieResponseModel.fromMap(json.decode(string));

  factory PharmacieResponseModel.fromMap(Map<String, dynamic> json) =>
      PharmacieResponseModel(
          status: json['status'] ?? 0,
          success: json['success'] ?? false,
          message: json['message'] ?? "",
          results: json['results'] == null
              ? []
              : List<Pharmacie>.from(
                  json['results'].map((x) => Pharmacie.fromMap(x))));

  Map<String, dynamic> toMap() => {
        'status': status,
        'success': success,
        'message': message,
        'results': results
      };

  String toJson() => json.encode(toMap());
}

class Pharmacie {
  final String? id;
  final String? nom;
  final String? localisation;
  final String? phone;
  final String? email;
  final int? stock;
  final double? latitude;
  final double? longitude;
  final double? distance;
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
      this.distance,
      this.ouverture,
      this.fermeture,
      this.user,
      this.created_at,
      this.updated_at});

  factory Pharmacie.fromJson(String string) =>
      Pharmacie.fromMap(json.decode(string));

  factory Pharmacie.fromMap(Map<String, dynamic> json) => Pharmacie(
      id: json['id'] as String?,
      nom: json['nom'] as String?,
      localisation: json['localisation'] as String?,
      phone: json['tel'] as String?,
      email: json['email'] as String?,
      stock: json['stock'] as int?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      distance: json['distance'] ?? -1,
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
        'distance': distance,
        'fermeture': fermeture,
        'user': user,
        'created_at': created_at,
        'updated_at': updated_at
      };

  String toJson() => json.encode(toMap());

  lp.Pharmacie convert() => lp.Pharmacie(
      idPharmacie: id,
      nom: nom,
      localisation: localisation,
      tel: phone,
      email: email,
      stock: stock,
      latitude: latitude,
      longitude: longitude,
      distance: distance,
      ouverture: ouverture,
      fermeture: fermeture,
      user: user,
      created_at: created_at,
      updated_at: updated_at);
}
