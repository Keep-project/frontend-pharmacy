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
  final int? categorie;
  final int? voix;
  final int? pharmacie;
  final int? entrepot;
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
