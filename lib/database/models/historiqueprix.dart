import 'dart:convert';

const String tableHistoriquePrix = "historiquePrix";

class HistoriquePrixFields {
  static const List<String> values = [
    id,
    basePrix,
    tva,
    prixVente,
    created_at,
    medicament,
    utilisateur
  ];

  static const String id = "_id";
  static const String basePrix = "basePrix";
  static const String tva = "tva";
  static const String prixVente = "prixVente";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String medicament = "medicament_id";
  static const String utilisateur = "utilisateur_id";
}

class HistoriquePrix {
  final int? id;
  final String? basePrix;
  final double? tva;
  final int? prixVente;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? medicament;
  final int? utilisateur;

  HistoriquePrix({this.id, this.basePrix, this.tva, this.prixVente, this.created_at, this.updated_at, this.medicament, this.utilisateur});

  factory HistoriquePrix.formJson(String string) => HistoriquePrix.fromMap(json.decode(string));

  factory HistoriquePrix.fromMap(Map<String, dynamic> json) => HistoriquePrix(
        id: json[HistoriquePrixFields.id] as int?,
        basePrix: json[HistoriquePrixFields.basePrix] as String?,
        tva: json[HistoriquePrixFields.tva] as double?,
        prixVente: json[HistoriquePrixFields.prixVente] as int?,
        created_at: DateTime.parse(json[HistoriquePrixFields.created_at] as String),
        updated_at: DateTime.parse(json[HistoriquePrixFields.updated_at] as String),
        medicament: json[HistoriquePrixFields.medicament] as int?,
        utilisateur: json[HistoriquePrixFields.utilisateur] as int?,
      );

  Map<String, dynamic> toMap() => {
        HistoriquePrixFields.id: id,
        HistoriquePrixFields.basePrix:basePrix,
        HistoriquePrixFields.prixVente: prixVente,
        HistoriquePrixFields.tva: tva,
        HistoriquePrixFields.created_at: created_at!.toIso8601String(),
        HistoriquePrixFields.updated_at: updated_at!.toIso8601String(),
        HistoriquePrixFields.medicament: medicament,
        HistoriquePrixFields.utilisateur: utilisateur,
      };

  HistoriquePrix copy({
    int? id,
    String? basePrix,
    double? tva,
    int? prixVente,
    DateTime? created_at,
    DateTime? updated_at,
    int? medicament,
    int? utilisateur,
  }) =>
      HistoriquePrix(
        id: id ?? this.id,
        basePrix: basePrix ?? this.basePrix,
        tva: tva ?? this.tva,
        prixVente: prixVente ?? this.prixVente,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        medicament: medicament ?? this.medicament,
        utilisateur: utilisateur ?? this.utilisateur,
      );
}
