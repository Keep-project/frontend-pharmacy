import 'dart:convert';

const String tableEntrepot = "entrepots";

class EntrepotFields {
  static const List<String> values = [
    id,
    nom,
    pays,
    ville,
    telephone,
    description,
    created_at,
    updated_at,
    pharmacie,
    isUpdate
  ];

  static const String id = "_id";
  static const String nom = "nom";
  static const String pays = "pays";
  static const String ville = "ville";
  static const String telephone = "telephone";
  static const String description = "description";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String pharmacie = "pharmacie_id";
  static const String isUpdate = "isUpdate";
}

class Entrepot {
  final int? id;
  final String? nom;
  final String? pays;
  final String? ville;
  final String? telephone;
  final String? description;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? pharmacie;
  final bool? isUpdate;

  Entrepot({this.id, this.nom, this.pays, this.ville, this.telephone, this.description, this.created_at, this.updated_at, this.pharmacie, this.isUpdate});

  factory Entrepot.formJson(String string) => Entrepot.fromMap(json.decode(string));

  factory Entrepot.fromMap(Map<String, dynamic> json) => Entrepot(
        id: json[EntrepotFields.id] as int?,
        nom: json[EntrepotFields.nom] as String?,
        pays: json[EntrepotFields.pays] as String?,
        ville: json[EntrepotFields.ville] as String?,
        telephone: json[EntrepotFields.telephone] as String?,
        description: json[EntrepotFields.description] as String?,
        created_at: DateTime.parse(json[EntrepotFields.created_at] as String),
        updated_at: DateTime.parse(json[EntrepotFields.updated_at] as String),
        pharmacie: json[EntrepotFields.pharmacie] as int?,
        isUpdate: json[EntrepotFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        EntrepotFields.id: id,
        EntrepotFields.nom: nom,
        EntrepotFields.pays: pays,
        EntrepotFields.ville: ville,
        EntrepotFields.telephone: telephone,
        EntrepotFields.description: description,
        EntrepotFields.created_at: created_at!.toIso8601String(),
        EntrepotFields.updated_at: updated_at!.toIso8601String(),
        EntrepotFields.pharmacie: pharmacie,
        EntrepotFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Entrepot copy({
    int? id,
    String? nom,
    String? pays,
    String? ville,
    String? telephone,
    String? description,
    DateTime? created_at,
    DateTime? updated_at,
    int? pharmacie,
    bool? isUpdate,
  }) =>
      Entrepot(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        pays: pays ?? this.pays,
        ville: ville ?? this.ville,
        telephone: telephone ?? this.telephone,
        description: description ?? this.description,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        pharmacie: pharmacie ?? this.pharmacie,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
