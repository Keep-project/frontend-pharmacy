import 'dart:convert';

const String tableCategorie = "categories";

class CategorieFields {
  static const List<String> values = [
    id,
    libelle,
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
}

class Categorie {
  final int? id;
  final String? libelle;

  Categorie({this.id, this.libelle});

  factory Categorie.formJson(String string) => Categorie.fromMap(json.decode(string));

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
        id: json[CategorieFields.id] as int?,
        libelle: json[CategorieFields.libelle] as String?,
        
      );

  Map<String, dynamic> toMap() => {
        CategorieFields.id: id,
        CategorieFields.libelle: libelle,
      };

  Categorie copy({
    int? id,
    String? libelle,
    
  }) =>
      Categorie(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
      );
}
