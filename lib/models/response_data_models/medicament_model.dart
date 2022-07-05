

import 'dart:convert';

class MedicamentRequestModel {

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Medicament>? results;

  MedicamentRequestModel({this.count, this.next, this.previous, this.results});

  factory MedicamentRequestModel.fromJson(String string) => MedicamentRequestModel.fromMap(json.decode(string));

  factory MedicamentRequestModel.fromMap(Map<String, dynamic> json) => MedicamentRequestModel(
    count: json['count'] ?? 0,
    next: json['next'],
    previous: json['previous'],
    results: json['results'] == null ? null : List<Medicament>.from(json['results'].map((x) => Medicament.fromMap(x)))
  );

  Map<String, dynamic> toMap() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results
  };

  String toJson() => json.encode(toMap());
  
}

class Medicament {
  final int? id;
  final String? nom;
  final int? prix;
  final String? marque;
  final DateTime? date_exp;
  final String? photo;
  final int? stock;
  final String? description;
  final String? posologie;
  final int? categorie;
  final int? user;
  final int? voix;
  final int? pharmacie;
  final DateTime? created_at;
  final DateTime? updated_at;

  Medicament({
    this.id,
    this.nom,
    this.prix,
    this.marque,
    this.date_exp,
    this.photo,
    this.stock,
    this.description,
    this.posologie,
    this.categorie,
    this.user,
    this.voix,
    this.pharmacie,
    this.created_at,
    this.updated_at });


    factory Medicament.fromJson(String string) => Medicament.fromMap(json.decode(string));

    factory Medicament.fromMap(Map<String, dynamic> json) => Medicament(
      id:  json["id"] ?? 0,
      nom: json["nom"] ?? "",
      prix: json["prix"] ?? 0,
      marque: json["marque"] ?? "",
      date_exp:json["date_exp"] == null ? null : DateTime.parse(json["date_exp"]),
      photo: json["get_image_url"] ?? "",
      stock: json["qte_stock"] ?? 0,
      description: json["description"] ?? "",
      posologie : json["posologie"] ??"",
      categorie: json["categorie"]?? 0,
      user: json["user"]?? 0,
      voix: json["voix"]?? 0,
      pharmacie: json["pharmacie"]?? 0,
      created_at: json["created_at"] == null ? null : DateTime.parse(json['created_at']),
      updated_at: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"])

    );

    Map<String, dynamic> toMap() => {
      'id': id,
      'nom': nom,
      'prix': prix,
      'marque': marque,
      'date_exp': date_exp,
      'photo': photo,
      'stock': stock,
      'description': description,
      'posologie': posologie,
      'categorie': categorie,
      'user': user,
      'voix': voix,
      'pharmacie': pharmacie,
      'created_at': created_at!.toIso8601String(),
      'updated_at': updated_at!.toIso8601String()                                                                            
    };

    String toJson() => json.encode(toMap());
}

