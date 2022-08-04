// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';

class EntrepotFormController extends GetxController{
  
final RemoteAuthenticationService _authService = RemoteAuthenticationServiceImpl();
LoadingStatus entrepotStatus = LoadingStatus.initial;

  


}