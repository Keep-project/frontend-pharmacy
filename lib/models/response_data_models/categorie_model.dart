

import 'dart:convert';

class CategorieRequestModel {

  final int? status;
  final bool? success;
  final String? message;
  final List<Categorie>? results;

  CategorieRequestModel({this.status, this.success, this.message, this.results});

  factory CategorieRequestModel.fromJson(String string) => CategorieRequestModel.fromMap(json.decode(string));

  factory CategorieRequestModel.fromMap(Map<String, dynamic> json) => CategorieRequestModel(
    status: json["status"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    results: json["results"] == null ? null : List<Categorie>.from(json["results"].map((e) => Categorie.fromJson(e))),
  );


  Map<String, dynamic> toMap() => {
    "success": success,
    "status": status,
    "message": message,
    "results": results
  };

  String toJson() => json.encode(toMap());


  
}


class Categorie {
  final int? id;
  final String? libelle;

  Categorie({this.id, this.libelle});


  factory Categorie.fromJson(String string) => Categorie.fromMap(json.decode(string));

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
    id: json['id'] ?? 0,
    libelle: json['lebelle'] ?? "",
  );


  Map<String, dynamic> toMap() => {
    'id': id,
    'libelle': libelle
  };

  String toJson() => json.encode(toMap());

}