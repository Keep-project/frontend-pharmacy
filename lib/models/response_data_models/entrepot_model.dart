import 'dart:convert';

import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';

class EntrepotResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Entrepot>? results;

  EntrepotResponseModel({this.count, this.next, this.previous, this.results});

  factory EntrepotResponseModel.fromJson(String string) =>
      EntrepotResponseModel.fromMap(json.decode(string));

  factory EntrepotResponseModel.fromMap(Map<String, dynamic> json) =>
      EntrepotResponseModel(
          count: json['count'] ?? 0,
          next: json['next'] ?? "",
          previous: json['previous'] ?? "",
          results: json['results'] == null
              ? []
              : List<Entrepot>.from(
                  json['results'].map((e) => Entrepot.fromMap(e))));

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results,
      };

  String toJson() => json.encode(toMap());
}

class Entrepot {
  final int? id;
  final String? nom;
  final String? pays;
  final String? ville;
  final String? telephone;
  final String? description;
  final int? pharmacie;
  final int? valeurVente;
  final DateTime? created_at;
  final DateTime? updated_at;

  Entrepot(
      {this.id,
      this.nom,
      this.pays,
      this.ville,
      this.telephone,
      this.description,
      this.pharmacie,
      this.valeurVente,
      this.created_at,
      this.updated_at});

  factory Entrepot.fromJson(String string) =>
      Entrepot.fromMap(json.decode(string));
  factory Entrepot.fromMap(Map<String, dynamic> json) => Entrepot(
        id: json['id'] ?? 0,
        nom: json['nom'] ?? "",
        pays: json['pays'] ?? "",
        ville: json['ville'] ?? "",
        telephone: json['telephone'] ?? "",
        description: json['description'] ?? "",
        pharmacie: json['pharmacie'] ?? 0,
        valeurVente: json['valeurVente'] ?? 0,
        created_at: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updated_at: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "pays": pays,
        "ville": ville,
        "telephone": telephone,
        "description": description,
        "pharmacie": pharmacie,
        'valeurVente': valeurVente,
        "created_at": created_at!.toIso8601String(),
        "updated_at": updated_at!.toIso8601String(),
      };

  String toJson() => json.encode(toMap());
}
