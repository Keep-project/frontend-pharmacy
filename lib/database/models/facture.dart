import 'dart:convert';

const String tableFacture = "factures";

class FactureFields {
  static const List<String> values = [
    id,
    quantiteTotal,
    montantTotal,
    reduction,
    note,
    created_at,
    updated_at,
    utilisateur
  ];

  static const String id = "_id";
  static const String montantTotal = "montantTotal";
  static const String quantiteTotal = "quantiteTotal";
  static const String reduction = "reduction";
  static const String note = "note";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String utilisateur = "utilisateur_id";
}

class Facture {
  final int? id;
  final int? montantTotal;
  final int? quantiteTotal;
  final int? reduction;
  final String? note;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? utilisateur;

  Facture({this.id, this.montantTotal, this.quantiteTotal, this.reduction, this.note, this.created_at, this.updated_at, this.utilisateur});

  factory Facture.formJson(String string) => Facture.fromMap(json.decode(string));

  factory Facture.fromMap(Map<String, dynamic> json) => Facture(
        id: json[FactureFields.id] as int?,
        montantTotal: json[FactureFields.montantTotal] as int?,
        quantiteTotal: json[FactureFields.quantiteTotal] as int?,
        reduction: json[FactureFields.reduction] as int?,
        note: json[FactureFields.note] as String?,
        created_at: DateTime.parse(json[FactureFields.created_at] as String),
        updated_at: DateTime.parse(json[FactureFields.updated_at] as String),
        utilisateur: json[FactureFields.utilisateur] as int?,
      );

  Map<String, dynamic> toMap() => {
        FactureFields.id: id,
        FactureFields.montantTotal:montantTotal,
        FactureFields.quantiteTotal: quantiteTotal,
        FactureFields.reduction: reduction,
        FactureFields.note: note,
        FactureFields.created_at: created_at!.toIso8601String(),
        FactureFields.updated_at: updated_at!.toIso8601String(),
        FactureFields.utilisateur: utilisateur,
      };

  Facture copy({
    int? id,
    int? montantTotal,
    int? quantiteTotal,
    int? reduction,
    String? note,
    DateTime? created_at,
    DateTime? updated_at,
    int? utilisateur,
  }) =>
      Facture(
        id: id ?? this.id,
        montantTotal: montantTotal ?? this.montantTotal,
        quantiteTotal: quantiteTotal ?? this.quantiteTotal,
        reduction: reduction ?? this.reduction,
        note: note ?? this.note,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        utilisateur: utilisateur ?? this.utilisateur,
      );
}
