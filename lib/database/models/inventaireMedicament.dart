import 'dart:convert';

const String tableInventaireMedicament = "inventaireMedicament";

class InventaireMedicamentFields {
  static const List<String> values = [
    id,
    quantiteAttendue,
    quantiteReelle,
    created_at,
    updated_at,
    inventaire,
    medicament,
  ];

  static const String id = "_id";
  static const String quantiteAttendue = "quantiteAttendue";
  static const String quantiteReelle = "quantiteReelle";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String inventaire = "inventaire_id";
  static const String medicament = "medicament_id";
}

class InventaireMedicament {
  final int? id;
  final int? quantiteAttendue;
  final int? quantiteReelle;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? inventaire;
  final int? medicament;

  InventaireMedicament({this.id, this.quantiteAttendue, this.quantiteReelle, this.created_at, this.updated_at, this.inventaire, this.medicament});

  factory InventaireMedicament.formJson(String string) => InventaireMedicament.fromMap(json.decode(string));

  factory InventaireMedicament.fromMap(Map<String, dynamic> json) => InventaireMedicament(
        id: json[InventaireMedicamentFields.id] as int?,
        quantiteAttendue: json[InventaireMedicamentFields.quantiteAttendue] as int?,
        quantiteReelle: json[InventaireMedicamentFields.quantiteReelle] as int?,
        created_at: DateTime.parse(json[InventaireMedicamentFields.created_at] as String),
        updated_at: DateTime.parse(json[InventaireMedicamentFields.updated_at] as String),
        inventaire: json[InventaireMedicamentFields.inventaire] as int?,
        medicament: json[InventaireMedicamentFields.medicament] as int?,
      );

  Map<String, dynamic> toMap() => {
        InventaireMedicamentFields.id: id,
        InventaireMedicamentFields.quantiteAttendue: quantiteAttendue,
        InventaireMedicamentFields.quantiteReelle: quantiteReelle,
        InventaireMedicamentFields.created_at: created_at!.toIso8601String(),
        InventaireMedicamentFields.updated_at: updated_at!.toIso8601String(),
        InventaireMedicamentFields.inventaire: inventaire,
        InventaireMedicamentFields.medicament: medicament,
      };

  InventaireMedicament copy({
    int? id,
    int? quantiteAttendue,
    int? quantiteReelle,
    DateTime? created_at,
    DateTime? updated_at,
    int? inventaire,
    int? medicament,
  }) =>
      InventaireMedicament(
        id: id ?? this.id,
        quantiteAttendue: quantiteAttendue ?? this.quantiteAttendue,
        quantiteReelle: quantiteReelle ?? this.quantiteReelle,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        inventaire: inventaire ?? this.inventaire,
        medicament: medicament ?? this.medicament,
      );
}
