
import 'package:pharmacy_app/services/local_services/authentication/authentication_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthentificationServiceImpl implements LocalAuthentificationService {
  @override
  Future<bool> deleteToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('PHARMACY_ACCESS_TOKEN');
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('PHARMACY_ACCESS_TOKEN');
  }


  @override
  Future<bool> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('PHARMACY_ACCESS_TOKEN', token);
    return true;
  }
  

  // @override
  // Future<bool> deleteUser() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   return _pref.remove(Constants.MAISONIER_LITE_USER);
  // }

  // @override
  // Future<bool> saveUser(user) async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   _pref.setString(Constants.MAISONIER_LITE_USER, user);
  //   return true;
  // }

  // @override
  // Future<dynamic> getUser() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   return  _pref.getString(Constants.MAISONIER_LITE_USER);
  // }

  
}
