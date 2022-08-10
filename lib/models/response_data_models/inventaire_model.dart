

import 'dart:convert';

class InventaireResponseModel {

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Inventaire>? results;

  InventaireResponseModel({this.count, this.next, this.previous, this.results});

  factory InventaireResponseModel.fromJson(String string) => InventaireResponseModel.fromMap(json.decode(string));

  factory InventaireResponseModel.fromMap(Map<String, dynamic> json) => InventaireResponseModel(
    count: json["count"] ?? 0,
    next: json["next"] ?? "",
    previous: json["previous"] ?? "",
    results: json["results"] == null ? [] : List<Inventaire>.from(json["results"].map((x) => Inventaire.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results
  };

  String toJson() => json.encode(toMap());
}


class Inventaire {
  final int? id;
  final String? libelle;
  final int? entrepot;
  final List<LigneInventaire>? lignesInventaire;
  final DateTime? created_at;
  final DateTime? updated_at;

  Inventaire({this.id, this.libelle, this.entrepot, this.lignesInventaire, this.created_at, this.updated_at});


factory Inventaire.fromJson(String string) => Inventaire.fromMap(json.decode(string));

factory Inventaire.fromMap(Map<String, dynamic> json) => Inventaire(
  id: json["id"] ?? 0,
  libelle: json["libelle"] ?? "",
  entrepot: json["entrepot"] ?? 0,
  lignesInventaire: json["produits"] == null ? [] : List<LigneInventaire>.from(json["produits"].map((x) => LigneInventaire.fromMap(x))),
  created_at: json['created_at']== null ? null : DateTime.parse(json['created_at']),
  updated_at: json['updated_at']== null ? null : DateTime.parse(json['updated_at']),
);

Map<String, dynamic> toMap() => {
  'id': id,
  'libelle': libelle,
  'entrepot': entrepot,
  'lignesInventaire': lignesInventaire,
  'created_at': created_at!.toIso8601String(),
  'updated_at': updated_at!.toIso8601String(),
};


String toJson() => json.encode(toMap());


}




class LigneInventaire {

  final int? id;
  final int? inventaire;
  final int? medicament;
  final int? quantiteAttendue;
  final int? quantiteReelle;
  final DateTime? created_at;
  final DateTime? updated_at;

  LigneInventaire({this.id, this.inventaire, this.medicament, this.quantiteAttendue, this.quantiteReelle, this.created_at, this.updated_at});
  

  factory LigneInventaire.fromJson(String string) => LigneInventaire.fromMap(json.decode(string));
  factory LigneInventaire.fromMap(Map<String, dynamic> json) => LigneInventaire(
    id: json['id'] ?? 0,
    inventaire: json['inventaire'] ?? 0,
    medicament: json['medicament'] ?? 0,
    quantiteAttendue: json['quantiteAttendue'] ?? "",
    quantiteReelle:  json['quantiteReelle'] ?? "",
    created_at: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updated_at: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'inventaire': inventaire,
    'medicament': medicament,
    'quantiteAttendue': quantiteAttendue,
    'quantiteReelle': quantiteReelle,
    'created_at': created_at!.toIso8601String(),
    'updated_at': updated_at!.toIso8601String(),
  };

  String toJson() => json.encode(toMap());
}
