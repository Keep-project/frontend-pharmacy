import 'dart:convert';

const String tableCarnet = "carnets";

class CarnetFields {
  static const List<String> values = [
    id,
    user,
    created_at,
    updated_at,
    consultation,
    maladie,
    isUpdate,
  ];

  static const String id = "_id";
  static const String user = "user";
  static const String created_at = "created_at";
  static const String updated_at = "updated_at";
  static const String consultation = "consultation_id";
  static const String maladie = "maladie_id";
  static const String isUpdate = "isUpdate";
}

class Carnet {
  final int? id;
  final int? user;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? consultation;
  final int? maladie;
  final bool? isUpdate;

  Carnet(
      {this.id,
      this.user,
      this.created_at,
      this.updated_at,
      this.consultation,
      this.maladie,
      this.isUpdate});

  factory Carnet.formJson(String string) => Carnet.fromMap(json.decode(string));

  factory Carnet.fromMap(Map<String, dynamic> json) => Carnet(
        id: json[CarnetFields.id] as int?,
        user: json[CarnetFields.user] as int?,
        created_at: DateTime.parse(json[CarnetFields.created_at] as String),
        updated_at: DateTime.parse(json[CarnetFields.updated_at] as String),
        consultation: json[CarnetFields.consultation] as int?,
        maladie: json[CarnetFields.maladie] as int?,
        isUpdate: json[CarnetFields.isUpdate] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        CarnetFields.id: id,
        CarnetFields.user: user,
        CarnetFields.created_at: created_at!.toIso8601String(),
        CarnetFields.updated_at: updated_at!.toIso8601String(),
        CarnetFields.consultation: consultation,
        CarnetFields.maladie: maladie,
        CarnetFields.isUpdate: isUpdate == true ? 1 : 0,
      };

  Carnet copy({
    int? id,
    int? user,
    DateTime? created_at,
    DateTime? updated_at,
    int? consultation,
    int? maladie,
    bool? isUpdate,
  }) =>
      Carnet(
        id: id ?? this.id,
        user: user ?? this.user,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        consultation: consultation ?? this.consultation,
        maladie: maladie ?? this.maladie,
        isUpdate: isUpdate ?? this.isUpdate
      );
}
