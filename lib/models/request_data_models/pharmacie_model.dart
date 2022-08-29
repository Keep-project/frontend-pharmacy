import 'dart:convert';

class PharmacieRequestModel {
  final String? nom;
  final String? email;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final String? localisation;
  final String? ouverture;
  final String? fermeture;

  PharmacieRequestModel(
      {this.nom,
      this.email,
      this.phone,
      this.latitude,
      this.longitude,
      this.localisation,
      this.ouverture,
      this.fermeture});

  Map<String, dynamic> toMap() => {
        'nom': nom,
        'email': email,
        'tel': phone,
        'latitude': latitude,
        'longitude': longitude,
        'localisation': localisation,
        'h_ouverture': ouverture,
        'h_fermeture':fermeture,

      };

  String toJson() => json.encode(toMap());
}
