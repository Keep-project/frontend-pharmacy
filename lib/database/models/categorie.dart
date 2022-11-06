import 'dart:convert';

const String tableCategorie = "categories";

class CategorieFields {
  static const List<String> values = [
    id,
    libelle,
    isUpdate,
  ];

  static const String id = "_id";
  static const String libelle = "libelle";
  static const String isUpdate = "isUpdate";
}

class Categorie {
  final int? id;
  final String? libelle;
  final bool? isUpdate;

  Categorie({this.id, this.libelle, this.isUpdate});

  factory Categorie.formJson(String string) => Categorie.fromMap(json.decode(string));

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
        id: json[CategorieFields.id] as int?,
        libelle: json[CategorieFields.libelle] as String?,
        isUpdate: json[CategorieFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        CategorieFields.id: id,
        CategorieFields.libelle: libelle,
        CategorieFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Categorie copy({
    int? id,
    String? libelle,
    bool? isUpdate,
    
  }) =>
      Categorie(
        id: id ?? this.id,
        libelle: libelle ?? this.libelle,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
