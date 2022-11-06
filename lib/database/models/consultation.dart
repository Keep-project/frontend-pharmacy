import 'dart:convert';

const String tableConsultation = "consultations";

class ConsultationFields {
  static const List<String> values = [
    id,
    user,
    created_at,
    updated_at,
    symptome,
    user,
    isUpdate,
  ];

  static const String id = "_id";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String symptome = "symptome_id";
  static const String user = "user_id";
  static const String isUpdate = "isUpdate";
}

class Consultation {
  final int? id;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? symptome;
  final int? user;
  final bool? isUpdate;

  Consultation({this.id, this.created_at, this.updated_at, this.symptome, this.user, this.isUpdate});

  factory Consultation.formJson(String string) => Consultation.fromMap(json.decode(string));

  factory Consultation.fromMap(Map<String, dynamic> json) => Consultation(
        id: json[ConsultationFields.id] as int?,
        created_at: DateTime.parse(json[ConsultationFields.created_at] as String),
        updated_at: DateTime.parse(json[ConsultationFields.updated_at] as String),
        symptome: json[ConsultationFields.symptome] as int?,
        user: json[ConsultationFields.user] as int?,
        isUpdate: json[ConsultationFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        ConsultationFields.id: id,
        ConsultationFields.created_at: created_at!.toIso8601String(),
        ConsultationFields.updated_at: updated_at!.toIso8601String(),
        ConsultationFields.symptome: symptome,
        ConsultationFields.user: user,
        ConsultationFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Consultation copy({
    int? id,
    DateTime? created_at,
    DateTime? updated_at,
    int? symptome,
    int? user,
    bool? isUpdate,
  }) =>
      Consultation(
        id: id ?? this.id,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        symptome: symptome ?? this.symptome,
        user: user ?? this.user,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
