import 'dart:convert';

const String tableMedicamentFacture = "medicamentFactures";

class MedicamentFactureFields {
  static const List<String> values = [
    id,
    montant,
    quantite,
    created_at,
    updated_at,
    facture,
    medicament,
    isUpdate
  ];

  static const String id = "_id";
  static const String montant = "montant";
  static const String quantite = "quantite";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String facture = "facture_id";
  static const String medicament = "medicament_id";
  static const String isUpdate = "isUpdate";
}

class MedicamentFacture {
  final int? id;
  final int? montant;
  final int? quantite;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? facture;
  final int? medicament;
  final bool? isUpdate;

  MedicamentFacture(
      {this.id,
      this.montant,
      this.quantite,
      this.created_at,
      this.updated_at,
      this.facture,
      this.medicament,
      this.isUpdate});

  factory MedicamentFacture.formJson(String string) =>
      MedicamentFacture.fromMap(json.decode(string));

  factory MedicamentFacture.fromMap(Map<String, dynamic> json) =>
      MedicamentFacture(
        id: json[MedicamentFactureFields.id] as int?,
        montant: json[MedicamentFactureFields.montant] as int?,
        quantite: json[MedicamentFactureFields.quantite] as int?,
        created_at:
            DateTime.parse(json[MedicamentFactureFields.created_at] as String),
        updated_at:
            DateTime.parse(json[MedicamentFactureFields.updated_at] as String),
        facture: json[MedicamentFactureFields.facture] as int?,
        medicament: json[MedicamentFactureFields.medicament] as int?,
        isUpdate: json[MedicamentFactureFields.isUpdate] == 1 ? true : false
      );

  Map<String, dynamic> toMap() => {
        MedicamentFactureFields.id: id,
        MedicamentFactureFields.montant: montant,
        MedicamentFactureFields.quantite: quantite,
        MedicamentFactureFields.created_at: created_at!.toIso8601String(),
        MedicamentFactureFields.updated_at: updated_at!.toIso8601String(),
        MedicamentFactureFields.facture: facture,
        MedicamentFactureFields.medicament: medicament,
        MedicamentFactureFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  MedicamentFacture copy({
    int? id,
    int? montant,
    int? quantite,
    DateTime? created_at,
    DateTime? updated_at,
    int? facture,
    int? medicament,
    bool? isUpdate,
  }) =>
      MedicamentFacture(
        id: id ?? this.id,
        montant: montant ?? this.montant,
        quantite: quantite ?? this.quantite,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        facture: facture ?? this.facture,
        medicament: medicament ?? this.medicament,
        isUpdate: isUpdate ?? this.isUpdate
      );
}
