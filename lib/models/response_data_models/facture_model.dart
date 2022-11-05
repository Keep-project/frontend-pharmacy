import 'dart:convert';

class FactureResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Facture>? results;

  FactureResponseModel({this.count, this.next, this.previous, this.results});

  factory FactureResponseModel.fromJson(String string) =>
      FactureResponseModel.fromMap(json.decode(string));

  factory FactureResponseModel.fromMap(Map<String, dynamic> json) =>
      FactureResponseModel(
          count: json['count'] ?? 0,
          next: json['next'] ?? '',
          previous: json['previous'] ?? '',
          results: json['results'] == null
              ? []
              : List<Facture>.from(
                  json['results'].map((x) => Facture.fromMap(x))));

    Map<String, dynamic> toMap() => {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results
    };

    String toJson() => json.encode(toMap());
}

class Facture {
  final String? id;
  final int? utilisateur;
  final int? montantTotal;
  final int? quantiteTotal;
  final int? reduction;
  final String? note;
  final String? username;
  final DateTime? created_at;
  final DateTime? updated_at;
  final List<LigneProduit>? produits;

  Facture({
      this.id,
      this.utilisateur,
      this.montantTotal,
      this.quantiteTotal,
      this.reduction,
      this.note,
      this.username,
      this.created_at,
      this.updated_at,
      this.produits
    });

  factory Facture.fromJson(String string) =>
      Facture.fromMap(json.decode(string));

  factory Facture.fromMap(Map<String, dynamic> json) => Facture(
      id: json['id'] ?? "",
      utilisateur: json['utilisateur'] ?? 0,
      montantTotal: json['montantTotal'] ?? 0,
      quantiteTotal: json['quantiteTotal'] ?? 0,
      reduction: json['reduction'] ?? 0.0,
      note: json['note'] ?? "",
      username: json['get_user_name'] ?? "",
      created_at: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updated_at: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      produits: json["produits"] == null
          ? []
          : List<LigneProduit>.from(
              json['produits'].map((e) => LigneProduit.fromMap(e))));

  Map<String, dynamic> toMap() => {
        'id': id,
        'utilisateur': utilisateur,
        'montantTotal': montantTotal,
        'quantiteTotal': quantiteTotal,
        'reduction': reduction,
        'note': note,
        'username': username,
        'created_at': created_at!.toIso8601String(),
        'updated_at': updated_at!.toIso8601String(),
        'produits': produits,
      };

  String toJson() => json.encode(toMap());

  String createdToString() => "${created_at!.year.toString().padLeft(4, '0')}-${created_at!.month.toString().padLeft(2, '0')}-${created_at!.day.toString().padLeft(2, '0')}";
  String updatedToString() => "${updated_at!.year.toString().padLeft(4, '0')}/${updated_at!.month.toString().padLeft(2, '0')}/${updated_at!.day.toString().padLeft(2, '0')}";
  String hourToString() => "${updated_at!.hour.toString().padLeft(2, '0')}h${updated_at!.minute.toString().padLeft(2, '0')}";

}

class LigneProduit {
  final String? id;
  final int? facture;
  final int? medicament;
  final int? montant;
  final int? quantite;
  final int? montantTotal;
  final String? productName;
  final DateTime? created_at;
  final DateTime? updated_at;

  LigneProduit(
      {this.id,
      this.facture,
      this.medicament,
      this.montant,
      this.quantite,
      this.montantTotal,
      this.productName,
      this.created_at,
      this.updated_at});

  factory LigneProduit.fromJson(String string) =>
      LigneProduit.fromMap(json.decode(string));

  factory LigneProduit.fromMap(Map<String, dynamic> json) => LigneProduit(
      id: json["id"] ?? "",
      facture: json["facture"] ?? 0,
      medicament: json["medicament"] ?? 0,
      montant: json["montant"] ?? 0,
      quantite: json["quantite"] ?? 0,
      montantTotal: json["montantTotal"] ?? 0,
      productName: json["get_medecine_name"] ?? "",
      created_at: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updated_at: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]));

  Map<String, dynamic> toMap() => {
        'id': id,
        'facture': facture,
        'medicament': medicament,
        'montant': montant,
        'quantite': quantite,
        'montantTotal': montantTotal,
        'productName': productName,
        'created_at': created_at!.toIso8601String(),
        'updated_at': updated_at!.toIso8601String(),
      };

  String toJson() => json.encode(toMap());
}
