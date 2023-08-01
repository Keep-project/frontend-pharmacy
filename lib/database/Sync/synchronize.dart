// ignore_for_file: avoid_print
import 'package:pharmacy_app/core/helpers.dart';
import 'package:pharmacy_app/database/models/medicament.dart';
import 'package:pharmacy_app/database/models/pharmacie.dart';
import 'package:pharmacy_app/database/sqflite_db.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart'
    as rm;

class SynchronizationData {
  static Future<bool> isInternet() async {
    return await (ConnectivityPlus.checkInternetConnection());
  }

  final PharmacieDatabase database = PharmacieDatabase.instance;

// Récupérer tous les médicaments de la base de données locale
  Future<List<Medicament>> readAllMedicament() async {
    List<Medicament> medicaments = await database.readAllMedicament();
    return medicaments;
  }

  // Récupérer tous les médicaments qui ont été mise à jour de la base de données locale
  Future<List<Medicament>> pushMedicament({int? update}) async {
    List<Medicament> medicaments =
        await database.readAllUpdateMedicament(update ?? 1);
    return medicaments;
  }

  // Récupérer un médicament à partir du champs idmedicament
  Future<Medicament?> readMedicamentByIdMedicament(String idMedicament) async {
    return await database.readMedicamentByIdMedicament(idMedicament);
  }

  // Ajout un médicament dans la base de données locale
  Future saveMedicament(rm.Medicament med) async {
    var medecine = await database.readMedicamentByName(med.nom!);
    if (medecine == null) {
      var medicament = await database.createMedicament(
        Medicament(
          idMedicament: med.id,
          nom: med.nom,
          prix: med.prix,
          isUpdate:
              false, // Variable permettant de savoir si l'objet a été mis à jour ou non
          marque: med.marque,
          basePrix: "TTC",
          tva: 19.25,
          dateExp: med.date_exp,
          image: med.photo,
          masse: med.masse,
          qteStock: med.stock,
          stockAlert: med.stockAlert,
          stockOptimal: med.stockOptimal,
          description: med.description,
          posologie: med.posologie,
          voix: med.voix,
          categorie: med.categorie,
          user: med.user,
          pharmaciename: med.pharmaciename,
          pharmacie: med.pharmacie,
          entrepot: med.entrepot,
          created_at: med.created_at,
          updated_at: med.updated_at,
        ),
      );
      print('Saved successfully ${medicament!.nom!}');
    } else {
      print('${med.nom} already exists in our database');
    }
  }

  // Ajout d'un pharmacie en base de donnée
  Future savePharmacie(Pharmacie pharmacie) async {
    var p = await database.createPharmacie(pharmacie);
  }

  Future<Pharmacie?> readPharmacieByIdPharmacie(String idPharmacie) async {
    return await database.readPharmacieByIdPharmacie(idPharmacie);
  }
}
