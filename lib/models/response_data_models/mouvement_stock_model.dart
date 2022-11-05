import 'dart:convert';

class MouvementStockResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<MouvementStock>? results;

  MouvementStockResponseModel(
      {this.count, this.next, this.previous, this.results});

  factory MouvementStockResponseModel.fromJson(String string) =>
      MouvementStockResponseModel.fromMap(json.decode(string));

  factory MouvementStockResponseModel.fromMap(Map<String, dynamic> json) =>
      MouvementStockResponseModel(
          count: json['count'] ?? 0,
          next: json['next'] ?? "",
          previous: json['previous'] ?? "",
          results: json['results'] == null
              ? []
              : List<MouvementStock>.from(
                  json['results'].map((e) => MouvementStock.fromMap(e))));

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results,
      };

  String toJson() => json.encode(toMap());
}

class MouvementStock {
  final String? id;
  final String? entrepot;
  final String? medicament;
  final String? description;
  final String? productName;
  final String? entrepotName;
  final int? quantite;
  final DateTime? created_at;
  final DateTime? updated_at;

  MouvementStock(
      {this.id,
      this.entrepot,
      this.medicament,
      this.description,
      this.productName,
      this.entrepotName,
      this.quantite,
      this.created_at,
      this.updated_at});

  factory MouvementStock.fromJson(String string) => MouvementStock.fromMap(json.decode(string));

  factory MouvementStock.fromMap(Map<String, dynamic> json) => MouvementStock(
    id : json['id'] ?? "",
    entrepot: json["entrepot"] ?? "",
    medicament: json['medicament'] ?? "",
    description: json['description'] ?? "",
    productName: json['get_medecine_name'] ?? "",
    entrepotName: json['get_entrepot_name'] ?? "",
    quantite: json['quantite'] ?? 0,
    created_at: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updated_at: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'entrepot': entrepot,
    'medicament': medicament,
    'description': description,
    'productName': productName,
    'entrepotName': entrepotName,
    'quantite': quantite,
    'created_at': created_at!.toIso8601String(),
    'updated_at': updated_at!.toIso8601String(),
  };

  String toJson() => json.encode(toMap());
  
  String createdToString() => "${created_at!.year.toString().padLeft(4, '0')}/${created_at!.month.toString().padLeft(2, '0')}/${created_at!.day.toString().padLeft(2, '0')}";
  String updatedToString() => "${updated_at!.year.toString().padLeft(4, '0')}/${updated_at!.month.toString().padLeft(2, '0')}/${updated_at!.day.toString().padLeft(2, '0')}";
  String hourToString() => "${updated_at!.hour.toString().padLeft(2, '0')}h${updated_at!.minute.toString().padLeft(2, '0')}";

}
