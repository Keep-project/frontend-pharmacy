
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {
  static Future<bool> isConnected() async => await InternetConnectionChecker().hasConnection;
}