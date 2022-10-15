import 'dart:convert';

const String tableMedicament = "medicaments";

class MedicamentFields {
  static const List<String> values = [
    id,
    idMedicament,
    nom,
    prix,
    marque,
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
    pharmacie,
    user,
    stockAlert,
    stockOptimal,
    entrepot
  ];

  static const String id = "_id";
  static const String idMedicament = "idMedicament";
  static const String nom = "nom";
  static const String prix = "prix";
  static const String marque = "marque";
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
  static const String pharmacie = "pharmacie_id";
  static const String user = "user_id";
  static const String stockAlert = "stockAlert";
  static const String stockOptimal = "stockOptimal";
  static const String entrepot = "entrepot_id";
}

class Medicament {
  final int? id;
  final int? idMedicament;
  final String? nom;
  final int? prix;
  final String? marque;
  final DateTime? dateExp;
  final String? image;
  final String? masse;
  final int? qteStock;
  final String? description;
  final String? posologie;
  final int? voix;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? categorie;
  final int? pharmacie;
  final int? user;
  final int? stockAlert;
  final int? stockOptimal;
  final int? entrepot;

  Medicament(
      {this.id,
      this.idMedicament,
      this.nom,
      this.prix,
      this.marque,
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
      this.pharmacie,
      this.user,
      this.stockAlert,
      this.stockOptimal,
      this.entrepot});

  factory Medicament.formJson(String string) =>
      Medicament.fromMap(json.decode(string));

  factory Medicament.fromMap(Map<String, dynamic> json) => Medicament(
        id: json[MedicamentFields.id] as int?,
        idMedicament: json[MedicamentFields.idMedicament] as int?,
        nom: json[MedicamentFields.nom] as String?,
        prix: json[MedicamentFields.prix] as int?,
        marque: json[MedicamentFields.marque] as String?,
        dateExp: DateTime.parse(json[MedicamentFields.dateExp] as String),
        image: json[MedicamentFields.image] as String?,
        masse: json[MedicamentFields.masse] as String?,
        qteStock: json[MedicamentFields.qteStock] as int?,
        description: json[MedicamentFields.description] as String?,
        posologie: json[MedicamentFields.posologie] as String?,
        voix: json[MedicamentFields.voix] as int?,
        created_at: DateTime.parse(json[MedicamentFields.created_at] as String),
        updated_at: DateTime.parse(json[MedicamentFields.updated_at] as String),
        categorie: json[MedicamentFields.categorie] as int?,
        pharmacie: json[MedicamentFields.pharmacie] as int?,
        user: json[MedicamentFields.user] as int?,
        stockAlert: json[MedicamentFields.stockAlert] as int?,
        stockOptimal: json[MedicamentFields.stockOptimal] as int?,
        entrepot: json[MedicamentFields.entrepot] as int?,
      );

  Map<String, dynamic> toMap() => {
        MedicamentFields.id: id,
        MedicamentFields.idMedicament: idMedicament,
        MedicamentFields.nom: nom,
        MedicamentFields.prix: prix,
        MedicamentFields.marque: marque,
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
        MedicamentFields.pharmacie: pharmacie,
        MedicamentFields.user: user,
        MedicamentFields.stockAlert: stockAlert,
        MedicamentFields.stockOptimal: stockOptimal,
        MedicamentFields.entrepot: entrepot
      };

  Medicament copy({
    int? id,
    int? idMedicament,
    String? nom,
    int? prix,
    String? marque,
    DateTime? dateExp,
    String? image,
    String? masse,
    int? qteStock,
    String? description,
    String? posologie,
    int? voix,
    DateTime? created_at,
    DateTime? updated_at,
    int? categorie,
    int? pharmacie,
    int? user,
    int? stockAlert,
    int? stockOptimal,
    int? entrepot,
  }) =>
      Medicament(
        id: id ?? this.id,
        idMedicament: idMedicament ?? this.idMedicament,
        nom: nom ?? this.nom,
        prix: prix ?? this.prix,
        marque: marque ?? this.marque,
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
        pharmacie: pharmacie ?? this.pharmacie,
        user: user ?? this.user,
        stockAlert: stockAlert ?? this.stockAlert,
        stockOptimal: stockOptimal ?? this.stockOptimal,
        entrepot: entrepot ?? this.entrepot,
      );
}
