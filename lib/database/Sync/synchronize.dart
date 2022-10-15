// ignore_for_file: avoid_print

import 'package:connectivity/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharmacy_app/database/models/medicament.dart';
import 'package:pharmacy_app/database/sqflite_db.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart'
    as rm;

class SynchronizationData {
  static Future<bool> isInternet() async {
    var connetivityResult = await (Connectivity().checkConnectivity());

    if (connetivityResult == ConnectivityResult.mobile) {
      if (await InternetConnectionChecker().hasConnection) {
        print("Mobile data detected & Internet connection confirmed");
        return true;
      } else {
        print('No internet :( Reason: mobile data');
        return false;
      }
    } else if (connetivityResult == ConnectivityResult.wifi) {
      if (await InternetConnectionChecker().hasConnection) {
        print("Wifi data detected & Internet connection confirmed");
        return true;
      } else {
        print('No internet :( Reason: wifi');
        return false;
      }
    } else {
      print(
          "Neither mobile data or Wifi connection detected. Not internet found");
      return false;
    }
  }

  final PharmacieDatabase database = PharmacieDatabase.instance;

  Future<List<Medicament>> readAllMedicament() async {
    List<Medicament> medicaments = await database.readAllMedicament();
    for (var md in medicaments) {
      print(md.toMap());
      print("\n\n");
    }
    return medicaments;
  }

  Future saveMedicament(rm.Medicament med) async {
    Medicament medicament = await database.createMedicament(
      Medicament(
        idMedicament: med.id,
        nom: med.nom,
        prix: med.prix,
        marque: med.marque,
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
        pharmacie: med.pharmacie,
        entrepot: med.entrepot,
        created_at: med.created_at,
        updated_at: med.updated_at,
      ),
    );
    print('Saved successfully ${medicament.nom}');
  }
}
