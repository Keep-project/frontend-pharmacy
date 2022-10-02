import 'dart:convert';

const String tableMaladie = "maladies";

class MaladieFields {
  static const List<String> values = [
    id,
    libelle,
    created_at,
    updated_at,
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
}

class Maladie {
  final int? id;
  final String? libelle;
  final DateTime? created_at;
  final DateTime? updated_at;

  Maladie({
    this.id,
    this.libelle,
    this.created_at,
    this.updated_at,
  });

  factory Maladie.formJson(String string) =>
      Maladie.fromMap(json.decode(string));

  factory Maladie.fromMap(Map<String, dynamic> json) => Maladie(
        id: json[MaladieFields.id] as int?,
        libelle: json[MaladieFields.libelle] as String?,
        created_at: DateTime.parse(json[MaladieFields.created_at] as String),
        updated_at: DateTime.parse(json[MaladieFields.updated_at] as String),
      );

  Map<String, dynamic> toMap() => {
        MaladieFields.id: id,
        MaladieFields.libelle: libelle,
        MaladieFields.created_at: created_at,
        MaladieFields.updated_at: updated_at,
      };

  Maladie copy({
    int? id,
    String? libelle,
    DateTime? created_at,
    DateTime? updated_at,
  }) =>
      Maladie(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
      );
}
