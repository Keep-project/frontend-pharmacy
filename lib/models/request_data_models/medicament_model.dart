// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class MedicamentRequestModel {
  final String? nom;
  final int? prix;
  final String? masse;
  final String? marque;
  final DateTime? date_exp;
  final int? qte_stock;
  final int? stockAlert;
  final int? stockOptimal;
  final String? description;
  final String? posologie;
  final String? categorie;
  final int? voix;
  final String? pharmacie;
  final String? entrepot;
  final double? tva;
  final String? basePrix;
  final String? image;

  MedicamentRequestModel({
    this.nom,
    this.prix,
    this.masse,
    this.marque,
    this.date_exp,
    this.qte_stock,
    this.stockAlert,
    this.stockOptimal,
    this.description,
    this.posologie,
    this.categorie,
    this.voix,
    this.pharmacie,
    this.entrepot,
    this.tva,
    this.basePrix,
    this.image,
  });


  factory MedicamentRequestModel.fromJson(String string) => MedicamentRequestModel.fromMap(json.decode(string));

  factory MedicamentRequestModel.fromMap(Map<String, dynamic> json) => MedicamentRequestModel(
    nom: json["nom"],
    prix: json["prix"],
    masse: json["masse"],
    marque: json["marque"],
    date_exp: DateTime.parse(json["date_exp"]),
    qte_stock: json["qte_stock"],
    stockAlert: json["stockAlert"],
    stockOptimal: json["stockOptimal"],
    description: json["description"],
    posologie: json["posologie"],
    categorie: json["categorie_id"],
    voix: json["voix"],
    pharmacie: json["pharmacie_id"],
    entrepot: json["entrepot_id"],
    tva: json["tva"] ?? 0.0,
    basePrix: json["basePrix"] ?? "",
    image: json["image"] ?? ""
  );

  Map<String, dynamic> toMap() => {
        'nom': nom,
        'prix': prix,
        'masse': masse,
        'marque': marque,
        'date_exp': date_exp!.toIso8601String(),
        'qte_stock': qte_stock,
        'stockAlert': stockAlert,
        'stockOptimal': stockOptimal,
        'description': description,
        'posologie': posologie,
        'categorie': categorie,
        'voix': voix,
        'pharmacie': pharmacie,
        'entrepot': entrepot,
        'tva': tva,
        'basePrix': basePrix,
        'image': image,
      };

  String toJson() => json.encode(toMap());
}
