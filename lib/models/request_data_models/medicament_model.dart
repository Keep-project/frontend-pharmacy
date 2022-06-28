import 'dart:convert';

class MedicamentRequestModel {

  final String? nom;
  final String? description;
  final String? image;
  final int? prix;
  final String? marque;
  final String? dateExpiration;
  final String? masse;
  final int? quantite;

  MedicamentRequestModel({this.nom, this.description, this.image, this.prix, this.marque, this.dateExpiration, this.masse, this.quantite});


  Map<String, dynamic> toMap() => {
    'nom': nom,
    'description': description,
    'image': image,
    'prix': prix,
    'marque': marque,
    'dateExpiration': dateExpiration,
    'masse': masse,
    'quantite': quantite,
  };


  String toJson() => json.encode(toMap());

}