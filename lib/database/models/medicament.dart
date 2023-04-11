import 'dart:convert';

import 'package:pharmacy_app/database/models/pharmacie.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart'
    as rm;

const String tableMedicament = "medicaments";

class MedicamentFields {
  static const List<String> values = [
    id,
    idMedicament,
    nom,
    prix,
    marque,
    basePrix,
    tva,
    dateExp,
    image,
    masse,
    qteStock,
    description,
    posologie,
    voix,
    created_at,
    updated_at,
    categorie,
    pharmaciename,
    pharmacie,
    user,
    stockAlert,
    stockOptimal,
    entrepot,
    isUpdate
  ];

  static const String id = "_id";
  static const String idMedicament = "idMedicament";
  static const String nom = "nom";
  static const String prix = "prix";
  static const String marque = "marque";
  static const String basePrix = "basePrix";
  static const String tva = "tva";
  static const String dateExp = "date_exp";
  static const String image = "image";
  static const String masse = "masse";
  static const String qteStock = "qte_stock";
  static const String description = "description";
  static const String posologie = "posologie";
  static const String voix = "voix";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String categorie = "categorie_id";
  static const String pharmaciename = "pharmaciename";
  static const String pharmacie = "pharmacie_id";
  static const String pharmacies = "pharmacies";
  static const String user = "user_id";
  static const String stockAlert = "stockAlert";
  static const String stockOptimal = "stockOptimal";
  static const String entrepot = "entrepot_id";
  static const String isUpdate = "isUpdate";
}

class Medicament {
  final int? id;
  final String? idMedicament;
  final String? nom;
  final int? prix;
  final String? marque;
  final String? basePrix;
  final double? tva;
  final DateTime? dateExp;
  final String? image;
  final String? masse;
  final int? qteStock;
  final String? description;
  final String? posologie;
  final int? voix;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? categorie;
  final String? pharmaciename;
  final String? pharmacie;
  final List<Pharmacie>? pharmacies;
  final int? user;
  final int? stockAlert;
  final int? stockOptimal;
  final String? entrepot;
  bool? isUpdate;

  Medicament(
      {this.id,
      this.idMedicament,
      this.nom,
      this.prix,
      this.marque,
      this.basePrix,
      this.tva,
      this.dateExp,
      this.image,
      this.masse,
      this.qteStock,
      this.description,
      this.posologie,
      this.voix,
      this.created_at,
      this.updated_at,
      this.categorie,
      this.pharmaciename,
      this.pharmacie,
      this.pharmacies,
      this.user,
      this.stockAlert,
      this.stockOptimal,
      this.entrepot,
      this.isUpdate});

  factory Medicament.formJson(String string) =>
      Medicament.fromMap(json.decode(string));

  factory Medicament.fromMap(Map<String, dynamic> json) => Medicament(
        id: json[MedicamentFields.id] as int?,
        idMedicament: json[MedicamentFields.idMedicament] as String?,
        nom: json[MedicamentFields.nom] as String?,
        prix: json[MedicamentFields.prix] as int?,
        marque: json[MedicamentFields.marque] as String?,
        basePrix: json[MedicamentFields.basePrix] as String?,
        tva: json[MedicamentFields.tva] as double?,
        dateExp: DateTime.parse(json[MedicamentFields.dateExp] as String),
        image: json[MedicamentFields.image] as String?,
        masse: json[MedicamentFields.masse] as String?,
        qteStock: json[MedicamentFields.qteStock] as int?,
        description: json[MedicamentFields.description] as String?,
        posologie: json[MedicamentFields.posologie] as String?,
        voix: json[MedicamentFields.voix] as int?,
        created_at: DateTime.parse(json[MedicamentFields.created_at] as String),
        updated_at: DateTime.parse(json[MedicamentFields.updated_at] as String),
        categorie: json[MedicamentFields.categorie] as String?,
        pharmaciename: json[MedicamentFields.pharmaciename] as String?,
        pharmacie: json[MedicamentFields.pharmacie] as String?,
        pharmacies: json[MedicamentFields.pharmacies] == null ? [] : List<Pharmacie>.from(json[MedicamentFields.pharmacies].map((x) => Pharmacie.fromMap(x))),
        user: json[MedicamentFields.user] as int?,
        stockAlert: json[MedicamentFields.stockAlert] as int?,
        stockOptimal: json[MedicamentFields.stockOptimal] as int?,
        entrepot: json[MedicamentFields.entrepot] as String?,
        isUpdate: json[MedicamentFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        MedicamentFields.id: id,
        MedicamentFields.idMedicament: idMedicament,
        MedicamentFields.nom: nom,
        MedicamentFields.prix: prix,
        MedicamentFields.marque: marque,
        MedicamentFields.basePrix: basePrix,
        MedicamentFields.tva: tva,
        MedicamentFields.dateExp: dateExp!.toIso8601String(),
        MedicamentFields.image: image,
        MedicamentFields.masse: masse,
        MedicamentFields.qteStock: qteStock,
        MedicamentFields.description: description,
        MedicamentFields.posologie: posologie,
        MedicamentFields.voix: voix,
        MedicamentFields.created_at: created_at!.toIso8601String(),
        MedicamentFields.updated_at: updated_at!.toIso8601String(),
        MedicamentFields.categorie: categorie,
        MedicamentFields.pharmaciename: pharmaciename,
        MedicamentFields.pharmacie: pharmacie,
        // MedicamentFields.pharmacies: pharmacies == null ? [] : List.from(pharmacies!.map((x) => x.toMap())),
        MedicamentFields.user: user,
        MedicamentFields.stockAlert: stockAlert,
        MedicamentFields.stockOptimal: stockOptimal,
        MedicamentFields.entrepot: entrepot,
        MedicamentFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Medicament copy(
          {int? id,
          String? idMedicament,
          String? nom,
          int? prix,
          String? marque,
          String? basePrix,
          double? tva,
          DateTime? dateExp,
          String? image,
          String? masse,
          int? qteStock,
          String? description,
          String? posologie,
          int? voix,
          DateTime? created_at,
          DateTime? updated_at,
          String? categorie,
          String? pharmaciename,
          String? pharmacie,
          int? user,
          int? stockAlert,
          int? stockOptimal,
          String? entrepot,
          bool? isUpdate}) =>
      Medicament(
          id: id ?? this.id,
          idMedicament: idMedicament ?? this.idMedicament,
          nom: nom ?? this.nom,
          prix: prix ?? this.prix,
          marque: marque ?? this.marque,
          basePrix: basePrix ?? this.basePrix,
          tva: tva ?? this.tva,
          dateExp: dateExp ?? this.dateExp,
          image: image ?? this.image,
          masse: masse ?? this.masse,
          qteStock: qteStock ?? this.qteStock,
          description: description ?? this.description,
          posologie: posologie ?? this.posologie,
          voix: voix ?? this.voix,
          created_at: created_at ?? this.created_at,
          updated_at: updated_at ?? this.updated_at,
          categorie: categorie ?? this.categorie,
          pharmaciename: pharmaciename ?? this.pharmaciename,
          pharmacie: pharmacie ?? this.pharmacie,
          user: user ?? this.user,
          stockAlert: stockAlert ?? this.stockAlert,
          stockOptimal: stockOptimal ?? this.stockOptimal,
          entrepot: entrepot ?? this.entrepot,
          isUpdate: isUpdate ?? this.isUpdate);

  rm.Medicament convert() => rm.Medicament(
      id: idMedicament,
      nom: nom,
      prix: prix,
      marque: marque,
      masse: masse,
      date_exp: dateExp,
      photo: image,
      stock: qteStock,
      stockAlert: stockAlert,
      stockOptimal: stockOptimal,
      description: description,
      posologie: posologie,
      pharmaciename: pharmaciename,
      categorie: categorie,
      user: user,
      voix: voix,
      pharmacie: pharmacie,
      created_at: created_at,
      updated_at: updated_at,
      entrepot: entrepot,
     );
}
