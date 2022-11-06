import 'dart:convert';

const String tableMaladie = "maladies";

class MaladieFields {
  static const List<String> values = [
    id,
    libelle,
    created_at,
    updated_at,
    isUpdate
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String isUpdate = "isUpdate";
}

class Maladie {
  final int? id;
  final String? libelle;
  final DateTime? created_at;
  final DateTime? updated_at;
  final bool? isUpdate;

  Maladie({
    this.id,
    this.libelle,
    this.created_at,
    this.updated_at,
    this.isUpdate
  });

  factory Maladie.formJson(String string) =>
      Maladie.fromMap(json.decode(string));

  factory Maladie.fromMap(Map<String, dynamic> json) => Maladie(
        id: json[MaladieFields.id] as int?,
        libelle: json[MaladieFields.libelle] as String?,
        created_at: DateTime.parse(json[MaladieFields.created_at] as String),
        updated_at: DateTime.parse(json[MaladieFields.updated_at] as String),
        isUpdate: json[MaladieFields.isUpdate] == 1 ? true : false
      );

  Map<String, dynamic> toMap() => {
        MaladieFields.id: id,
        MaladieFields.libelle: libelle,
        MaladieFields.created_at: created_at,
        MaladieFields.updated_at: updated_at,
        MaladieFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Maladie copy({
    int? id,
    String? libelle,
    DateTime? created_at,
    DateTime? updated_at,
    bool? isUpdate,
  }) =>
      Maladie(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
