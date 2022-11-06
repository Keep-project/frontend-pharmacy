import 'dart:convert';

const String tablePharmacie = "pharmacies";

class PharmacieFields {
  static const List<String> values = [
    id,
    libelle,
    nom,
    localisation,
    tel,
    latitude,
    longitude,
    ouverture,
    fermeture,
    created_at,
    updated_at,
    user,
    email,
    isUpdate
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
  static const String nom = "nom";
  static const String localisation = "localisation";
  static const String tel = "tel";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String ouverture = "h_ouverture";
  static const String fermeture = "h_fermeture";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String user = "user_id";
  static const String email = "email";
  static const String isUpdate = "isUpdate";
}

class Pharmacie {
  final int? id;
  final String? libelle;
  final String? nom;
  final String? localisation;
  final String? tel;
  final double? latitude;
  final double? longitude;
  final String? ouverture;
  final String? fermeture;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? user;
  final String? email;
  final bool? isUpdate;

  Pharmacie({this.id, this.libelle, this.nom, this.localisation, this.tel, this.latitude, this.longitude, this.ouverture, this.fermeture, this.created_at, this.updated_at, this.user, this.email, this.isUpdate});

  factory Pharmacie.formJson(String string) =>
      Pharmacie.fromMap(json.decode(string));

  factory Pharmacie.fromMap(Map<String, dynamic> json) =>
      Pharmacie(
        id: json[PharmacieFields.id] as int?,
        libelle: json[PharmacieFields.libelle] as String?,
        nom: json[PharmacieFields.nom] as String?,
        localisation: json[PharmacieFields.localisation] as String?,
        tel: json[PharmacieFields.tel] as String?,
        latitude: json[PharmacieFields.latitude] as double?,
        longitude: json[PharmacieFields.longitude] as double?,
        ouverture: json[PharmacieFields.ouverture] as String?,
        fermeture: json[PharmacieFields.fermeture] as String?,
        created_at:
            DateTime.parse(json[PharmacieFields.created_at] as String),
        updated_at:
            DateTime.parse(json[PharmacieFields.updated_at] as String),
        user: json[PharmacieFields.user] as int?,
        email: json[PharmacieFields.email] as String?,
        isUpdate: json[PharmacieFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        PharmacieFields.id: id,
        PharmacieFields.libelle: libelle,
        PharmacieFields.nom: nom,
        PharmacieFields.localisation: localisation,
        PharmacieFields.tel: tel,
        PharmacieFields.latitude: latitude,
        PharmacieFields.longitude: longitude,
        PharmacieFields.ouverture: ouverture,
        PharmacieFields.fermeture: fermeture,
        PharmacieFields.created_at: created_at!.toIso8601String(),
        PharmacieFields.updated_at: updated_at!.toIso8601String(),
        PharmacieFields.user: user,
        PharmacieFields.email: email,
        PharmacieFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Pharmacie copy({
    int? id,
  String? libelle,
  String? nom,
  String? localisation,
  String? tel,
  double? latitude,
  double? longitude,
  String? ouverture,
  String? fermeture,
  DateTime? created_at,
  DateTime? updated_at,
  int? user,
  String? email,
  bool? isUpdate,
  }) =>
      Pharmacie(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        nom: nom ?? this.nom,
        localisation: localisation ?? this.localisation,
        tel: tel ?? this.tel,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        ouverture: ouverture ?? this.ouverture,
        fermeture: fermeture ?? this.fermeture,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        user: user ?? this.user,
        email: email ?? this.email,
        isUpdate: isUpdate ?? this.isUpdate
      );
}
