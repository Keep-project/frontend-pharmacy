import 'dart:convert';

const String tableSymptome = "symptomes";

class SymptomeFields {
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

class Symptome {
  final int? id;
  final String? libelle;
  final DateTime? created_at;
  final DateTime? updated_at;
  final bool? isUpdate;

  Symptome({
    this.id,
    this.libelle,
    this.created_at,
    this.updated_at,
    this.isUpdate
  });

  factory Symptome.formJson(String string) =>
      Symptome.fromMap(json.decode(string));

  factory Symptome.fromMap(Map<String, dynamic> json) => Symptome(
        id: json[SymptomeFields.id] as int?,
        libelle: json[SymptomeFields.libelle] as String?,
        created_at: DateTime.parse(json[SymptomeFields.created_at] as String),
        updated_at: DateTime.parse(json[SymptomeFields.updated_at] as String),
        isUpdate: json[SymptomeFields.isUpdate] == 1 ? true : false
      );

  Map<String, dynamic> toMap() => {
        SymptomeFields.id: id,
        SymptomeFields.libelle: libelle,
        SymptomeFields.created_at: created_at,
        SymptomeFields.updated_at: updated_at,
        SymptomeFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Symptome copy({
    int? id,
    String? libelle,
    DateTime? created_at,
    DateTime? updated_at,
    bool? isUpdate
  }) =>
      Symptome(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        isUpdate: isUpdate ?? this.isUpdate
      );
}
