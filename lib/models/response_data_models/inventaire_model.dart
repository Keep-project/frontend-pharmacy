import 'dart:convert';

class InventaireResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Inventaire>? results;

  InventaireResponseModel({this.count, this.next, this.previous, this.results});

  factory InventaireResponseModel.fromJson(String string) =>
      InventaireResponseModel.fromMap(json.decode(string));

  factory InventaireResponseModel.fromMap(Map<String, dynamic> json) =>
      InventaireResponseModel(
        count: json["count"] ?? 0,
        next: json["next"] ?? "",
        previous: json["previous"] ?? "",
        results: json["results"] == null
            ? []
            : List<Inventaire>.from(
                json["results"].map((x) => Inventaire.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {'count': count, 'next': next, 'previous': previous, 'results': results};

  String toJson() => json.encode(toMap());
}

class Inventaire {
  final String? id;
  final String? libelle;
  final String? entrepot;
  final String? entrepotName;
  final List<LigneInventaire>? lignesInventaire;
  final DateTime? created_at;
  final DateTime? updated_at;

  Inventaire(
      {this.id,
      this.libelle,
      this.entrepot,
      this.entrepotName,
      this.lignesInventaire,
      this.created_at,
      this.updated_at});

  factory Inventaire.fromJson(String string) =>
      Inventaire.fromMap(json.decode(string));

  factory Inventaire.fromMap(Map<String, dynamic> json) => Inventaire(
        id: json["id"] ?? "",
        libelle: json["libelle"] ?? "",
        entrepot: json["entrepot"] ?? 0,
        entrepotName: json["get_entrepot_name"] ?? "",
        lignesInventaire: json["produits"] == null
            ? []
            : List<LigneInventaire>.from(
                json["produits"].map((x) => LigneInventaire.fromMap(x))),
        created_at: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updated_at: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'libelle': libelle,
        'entrepot': entrepot,
        'entrepotName': entrepotName,
        'lignesInventaire': lignesInventaire,
        'created_at': created_at!.toIso8601String(),
        'updated_at': updated_at!.toIso8601String(),
      };

  String toJson() => json.encode(toMap());

  String createdToString() =>
      "${created_at!.year.toString().padLeft(4, '0')}/${created_at!.month.toString().padLeft(2, '0')}/${created_at!.day.toString().padLeft(2, '0')}";
  String updatedToString() =>
      "${updated_at!.year.toString().padLeft(4, '0')}/${updated_at!.month.toString().padLeft(2, '0')}/${updated_at!.day.toString().padLeft(2, '0')}";
  String hourToString() =>
      "${updated_at!.hour.toString().padLeft(2, '0')}h${updated_at!.minute.toString().padLeft(2, '0')}";
}

class LigneInventaire {
  final String? id;
  final String? inventaire;
  final String? medicament;
  final String? productName;
  final int? quantiteAttendue;
  final int? quantiteReelle;
  final DateTime? created_at;
  final DateTime? updated_at;

  LigneInventaire(
      {this.id,
      this.inventaire,
      this.medicament,
      this.productName,
      this.quantiteAttendue,
      this.quantiteReelle,
      this.created_at,
      this.updated_at});

  factory LigneInventaire.fromJson(String string) =>
      LigneInventaire.fromMap(json.decode(string));
  factory LigneInventaire.fromMap(Map<String, dynamic> json) => LigneInventaire(
        id: json['id'] ?? "",
        inventaire: json['inventaire'] ?? "",
        medicament: json['medicament'] ?? "",
        productName: json['get_medecine_name'] ?? 0,
        quantiteAttendue: json['quantiteAttendue'] ?? "",
        quantiteReelle: json['quantiteReelle'] ?? "",
        created_at: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updated_at: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'inventaire': inventaire,
        'medicament': medicament,
        'productName': productName,
        'quantiteAttendue': quantiteAttendue,
        'quantiteReelle': quantiteReelle,
        'created_at': created_at!.toIso8601String(),
        'updated_at': updated_at!.toIso8601String(),
      };

  String toJson() => json.encode(toMap());
}
