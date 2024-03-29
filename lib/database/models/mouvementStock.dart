import 'dart:convert';

const String tableMouvementStock = "mouvementStocks";

class MouvementStockFields {
  static const List<String> values = [
    id,
    description,
    quantite,
    created_at,
    updated_at,
    entrepot,
    medicament,
    isUpdate
  ];

  static const String id = "_id";
  static const String description = "description";
  static const String quantite = "quantite";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String entrepot = "entrepot_id";
  static const String medicament = "medicament_id";
  static const String isUpdate = "isUpdate";
}

class MouvementStock {
  final int? id;
  final String? description;
  final int? quantite;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? entrepot;
  final int? medicament;
  final bool? isUpdate;

  MouvementStock(
      {this.id,
      this.description,
      this.quantite,
      this.created_at,
      this.updated_at,
      this.entrepot,
      this.medicament,
      this.isUpdate});

  factory MouvementStock.formJson(String string) =>
      MouvementStock.fromMap(json.decode(string));

  factory MouvementStock.fromMap(Map<String, dynamic> json) =>
      MouvementStock(
        id: json[MouvementStockFields.id] as int?,
        description: json[MouvementStockFields.description] as String?,
        quantite: json[MouvementStockFields.quantite] as int?,
        created_at:
            DateTime.parse(json[MouvementStockFields.created_at] as String),
        updated_at:
            DateTime.parse(json[MouvementStockFields.updated_at] as String),
        entrepot: json[MouvementStockFields.entrepot] as int?,
        medicament: json[MouvementStockFields.medicament] as int?,
        isUpdate: json[MouvementStockFields.isUpdate] == 1 ? true : false
      );

  Map<String, dynamic> toMap() => {
        MouvementStockFields.id: id,
        MouvementStockFields.description: description,
        MouvementStockFields.quantite: quantite,
        MouvementStockFields.created_at: created_at!.toIso8601String(),
        MouvementStockFields.updated_at: updated_at!.toIso8601String(),
        MouvementStockFields.entrepot: entrepot,
        MouvementStockFields.medicament: medicament,
        MouvementStockFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  MouvementStock copy({
    int? id,
    String? description,
    int? quantite,
    DateTime? created_at,
    DateTime? updated_at,
    int? entrepot,
    int? medicament,
    bool? isUpdate
  }) =>
      MouvementStock(
        id: id ?? this.id,
        description: description ?? this.description,
        quantite: quantite ?? this.quantite,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        entrepot: entrepot ?? this.entrepot,
        medicament: medicament ?? this.medicament,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
