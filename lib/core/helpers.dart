
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {
  // Cette méthode permet de savoir sii un appareil est connecté à internet ou non 
  // Et par conséquent renvoie la réponse true s'il la connection est active et faux dans le cass échéant
  static Future<bool> isConnected() async => await InternetConnectionChecker().hasConnection;
}