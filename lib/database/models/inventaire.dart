import 'dart:convert';

const String tableInventaire = "inventaires";

class InventaireFields {
  static const List<String> values = [
    id,
    libelle,
    created_at,
    updated_at,
    entrepot,
    isUpdate
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String entrepot = "entrepot_id";
  static const String isUpdate = "isUpdate";
}

class Inventaire {
  final int? id;
  final String? libelle;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? entrepot;
  final  bool? isUpdate;

  Inventaire({this.id, this.libelle, this.created_at, this.updated_at, this.entrepot, this.isUpdate});

  factory Inventaire.formJson(String string) => Inventaire.fromMap(json.decode(string));

  factory Inventaire.fromMap(Map<String, dynamic> json) => Inventaire(
        id: json[InventaireFields.id] as int?,
        libelle: json[InventaireFields.libelle] as String?,
        created_at: DateTime.parse(json[InventaireFields.created_at] as String),
        updated_at: DateTime.parse(json[InventaireFields.updated_at] as String),
        entrepot: json[InventaireFields.entrepot] as int?,
        isUpdate: json[InventaireFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        InventaireFields.id: id,
        InventaireFields.libelle: libelle,
        InventaireFields.created_at: created_at!.toIso8601String(),
        InventaireFields.updated_at: updated_at!.toIso8601String(),
        InventaireFields.entrepot: entrepot,
        InventaireFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Inventaire copy({
    int? id,
    String? libelle,
    DateTime? created_at,
    DateTime? updated_at,
    int? entrepot,
    bool? isUpdate,
  }) =>
      Inventaire(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        entrepot: entrepot ?? this.entrepot,
        isUpdate: isUpdate ?? this.isUpdate
      );
}
