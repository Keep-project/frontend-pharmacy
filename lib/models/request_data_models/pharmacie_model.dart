
import 'dart:convert';

class PharmacieRequestModel {
  final String? nom;
  final String? email;
  final String? phone;
  final List<double>? coordinates;
  final String? localisation;

  PharmacieRequestModel({this.nom, this.email, this.phone, this.coordinates, this.localisation});


 Map<String, dynamic> toMap() => {
    'nom': nom,
    'email': email,
    'phone': phone,
    'coordinates': coordinates,
    'localisation': localisation,
 };

 String toJson() => json.encode(toMap());
  
}