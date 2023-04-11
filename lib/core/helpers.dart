
import 'package:connectivity/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {
  // Cette méthode permet de savoir si un appareil est connecté à internet ou non 
  // Et par conséquent renvoie la réponse true s'il la connection est active et faux dans le cas échéant
  static Future<bool> isConnected() async => await InternetConnectionChecker().hasConnection;
}

class ConnectivityPlus {
  // Pour utiliser cette classe, le package connectivity_plus de flutter doit être installé
  static Future<bool> checkInternetConnection() async {
    ConnectivityResult  connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult ==  ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }
}