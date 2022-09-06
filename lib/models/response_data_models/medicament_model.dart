

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:pharmacy_app/models/response_data_models/entrepot_model.dart';
import 'package:pharmacy_app/models/response_data_models/facture_model.dart';
import 'package:pharmacy_app/models/response_data_models/historique_prix_model.dart';
import 'package:pharmacy_app/models/response_data_models/pharmacie_model.dart';
import 'package:pharmacy_app/models/response_data_models/user_data.dart';

class MedicamentResponseModel {

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Medicament>? results;

  MedicamentResponseModel({this.count, this.next, this.previous, this.results});

  factory MedicamentResponseModel.fromJson(String string) => MedicamentResponseModel.fromMap(json.decode(string));

  factory MedicamentResponseModel.fromMap(Map<String, dynamic> json) => MedicamentResponseModel(
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
  final String? masse;
  final String? marque;
  final DateTime? date_exp;
  final String? photo;
  final int? stock;
  final int? stockAlert;
  final int? stockOptimal;
  final String? description;
  final String? posologie;
  final String? pharmaciename;
  final int? categorie;
  final int? user;
  final int? voix;
  final User? createur;
  final int? pharmacie;
  final List<Pharmacie>? pharmacies;
  final List<Entrepot>? entrepots;
  final List<Facture>? references;
  final List<HistoriquePrix>? historiques;
  final int? entrepot;
  final DateTime? created_at;
  final DateTime? updated_at;

  Medicament({
    this.id,
    this.nom,
    this.prix,
    this.masse,
    this.marque,
    this.date_exp,
    this.photo,
    this.stock,
    this.stockAlert,
    this.stockOptimal,
    this.description,
    this.posologie,
    this.pharmaciename,
    this.categorie,
    this.user,
    this.voix,
    this.createur,
    this.pharmacie,
    this.pharmacies,
    this.entrepots,
    this.references,
    this.historiques,
    this.entrepot,
    this.created_at,
    this.updated_at
  });

    factory Medicament.fromJson(String string) => Medicament.fromMap(json.decode(string));

    factory Medicament.fromMap(Map<String, dynamic> json) => Medicament(
      id:  json["id"] ?? 0,
      nom: json["nom"] ?? "",
      prix: json["prix"] ?? 0,
      masse: json["masse"]?? "",
      marque: json["marque"] ?? "",
      date_exp: json["date_exp"] == null ? null : DateTime.parse(json["date_exp"]),
      photo: json["get_image_url"] ?? "",
      stock: json["qte_stock"] ?? 0,
      stockAlert: json["stockAlert"] ?? 0,
      stockOptimal: json["stockOptimal"] ?? 0,
      description: json["description"] ?? "",
      posologie : json["posologie"] ??"",
      pharmaciename: json["get_pharmacie_name"] ?? "",
      categorie: json["categorie"]?? 0,
      user: json["user"] ?? 0,
      voix: json["voix"] ?? 0,
      createur: json["proprietaire"] == null ? null : User.fromMap(json['proprietaire']),
      pharmacie: json["pharmacie"] ?? 0,
      pharmacies: json["pharmacies"] == null ? [] : List<Pharmacie>.from(json["pharmacies"].map((e) => Pharmacie.fromMap(e))),
      entrepots: json["entrepots"] == null ? [] : List<Entrepot>.from(json["entrepots"].map((e) => Entrepot.fromMap(e))),
      references: json["references"] == null ? [] : List<Facture>.from(json["references"].map((e) => Facture.fromMap(e))),
      historiques: json["historiques"] == null ? [] : List<HistoriquePrix>.from(json["historiques"].map((e) => HistoriquePrix.fromMap(e))),
      entrepot: json["entrepot"]?? 0,
      created_at: json["created_at"] == null ? null : DateTime.parse(json['created_at']),
      updated_at: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    String dateToString() => "${date_exp!.year.toString().padLeft(4, '0')}/${date_exp!.month.toString().padLeft(2, '0')}/${date_exp!.day.toString().padLeft(2, '0')}";
    String createdToString() => "${created_at!.year.toString().padLeft(4, '0')}/${created_at!.month.toString().padLeft(2, '0')}/${created_at!.day.toString().padLeft(2, '0')}";
    String updatedToString() => "${updated_at!.year.toString().padLeft(4, '0')}/${updated_at!.month.toString().padLeft(2, '0')}/${updated_at!.day.toString().padLeft(2, '0')}";

    Map<String, dynamic> toMap() => {
      'id': id,
      'nom': nom,
      'prix': prix,
      'masse': masse,
      'marque': marque,
      'date_exp': date_exp,
      'photo': photo,
      'stock': stock,
      'stockAlert': stockAlert,
      'stockOptimal': stockOptimal,
      'description': description,
      'posologie': posologie,
      'pharmaciename': pharmaciename,
      'categorie': categorie,
      'user': user,
      'voix': voix,
      'createur': createur,
      'pharmacie': pharmacie,
      'pharmacies': pharmacies,
      'entrepots': entrepots,
      'references': references,
      'historiques': historiques,
      'entrepot': entrepot,
      'created_at': created_at!.toIso8601String(),
      'updated_at': updated_at!.toIso8601String()                                                                            
    };

    String toJson() => json.encode(toMap());
}

