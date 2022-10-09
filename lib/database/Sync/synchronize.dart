

// ignore_for_file: avoid_print

import 'package:connectivity/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharmacy_app/database/models/note.dart';
import 'package:pharmacy_app/database/pharmacy_db.dart';

class SynchronizationData {
    static Future<bool> isInternet() async {
      var connetivityResult = await ( Connectivity().checkConnectivity());

      if ( connetivityResult == ConnectivityResult.mobile) {
        if ( await InternetConnectionChecker().hasConnection) {
          print("Mobile data detected & Internet connection confirmed");
          return true;
        }
        else {
          print('No internet :( Reason: mobile data');
          return false;
        }
      }
      else if ( connetivityResult == ConnectivityResult.wifi) {
        if ( await InternetConnectionChecker().hasConnection) {
          print("Wifi data detected & Internet connection confirmed");
          return true;
        }
        else {
          print('No internet :( Reason: wifi');
          return false;
        }
      }
      else {
        print("Neither mobile data or Wifi connection detected. Not internet found");
        return false;
      }
    }

    final PharmacieDatabase database = PharmacieDatabase.instance;

    Future<List<Note>> fetchAllNotes() async => await database.readAll();

    Future saveOnline(List<Note> notes) async {
      for (Note note in notes) {
        print("=====================================================");
        print("Save data online");
        print(note.toMap());
        print("=====================================================");
      }
    }
}