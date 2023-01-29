import 'dart:convert';

class HistoriquePrix {
  final String? id;
  final String? basePrix;
  final double? tva;
  final int? prixVente;
  final String? medicament;
  final int? utilisateur;
  final DateTime? created_at;
  final DateTime? updated_at;

  HistoriquePrix(
      {this.id,
      this.basePrix,
      this.tva,
      this.prixVente,
      this.medicament,
      this.utilisateur,
      this.created_at,
      this.updated_at});

  factory HistoriquePrix.fromJson(String string) =>
      HistoriquePrix.fromMap(json.decode(string));
  factory HistoriquePrix.fromMap(Map<String, dynamic> json) => HistoriquePrix(
        id: json['id'] as String?,
        basePrix: json['basePrix'] ?? 'HT',
        tva: json['tva'] ?? 19.25,
        prixVente: json['prixVente'] as int?,
        medicament: json['medicament'] as String?,
        utilisateur: json['utilisateur'] ?? 0,
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'basePrix': basePrix,
    'tva': tva,
    'prixVente': prixVente,
    'medicament': medicament,
    'utilisateur': utilisateur,
    'created_at': created_at!.toIso8601String(),
    'updated_at': updated_at!.toIso8601String()
  };

  String toJson() => json.encode(toMap());

  String createdToString() =>
      "${created_at!.year.toString().padLeft(4, '0')}/${created_at!.month.toString().padLeft(2, '0')}/${created_at!.day.toString().padLeft(2, '0')}";
  String updatedToString() =>
      "${updated_at!.year.toString().padLeft(4, '0')}/${updated_at!.month.toString().padLeft(2, '0')}/${updated_at!.day.toString().padLeft(2, '0')}";
}
