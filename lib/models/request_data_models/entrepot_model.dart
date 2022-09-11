

class EntrepotRequestModel {
  final String? nom;
  final String? pays;
  final String? ville;
  final String? telephone;
  final String? description;
  final int? pharmacie;

  EntrepotRequestModel({
      this.nom,
      this.pays,
      this.ville,
      this.telephone,
      this.description,
      this.pharmacie
    });

  

  Map<String, dynamic> toMap() => {
        "nom": nom,
        "pays": pays,
        "ville": ville,
        "telephone": telephone,
        "description": description,
        "pharmacie": pharmacie,
      };
}
