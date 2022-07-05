// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/login_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';
import 'package:pharmacy_app/services/remote_services/utilisateur/utilisateur.dart';

class LoginScreenController extends GetxController{

  bool obscureText = true;

  final RemoteAuthenticationService _authService =
      RemoteAuthenticationServiceImpl();

  final LocalAuthentificationService _localAuth =
      LocalAuthentificationServiceImpl();

  LoadingStatus loginStatus = LoadingStatus.initial;

  final UtilisateurService _userService = UtilisateurServiceImpl();

  final TextEditingController textEditingNom = TextEditingController();
  final TextEditingController textEditingPassword = TextEditingController();


  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingPassword.dispose();
    super.dispose();
  }

  @override 
  void onInit() async {
    super.onInit();
  }


  Future getUser() async {
    await _userService.getUser(onSuccess: (data) async {
      await _localAuth.saveUser(json.encode(data.results!.toMap()));
      // Map<String, dynamic> userJson = await UserInfo.user();
      Future.delayed(const Duration(seconds: 1), (){
        Get.offAllNamed(AppRoutes.HOME);
        loginStatus = LoadingStatus.completed;
        update();
      }) ;
    },

    onError: (error) {
      print("================== login / info =================");
      print(error);
      print("=================================================");
    });
  }

  Future login(BuildContext context) async {
    loginStatus = LoadingStatus.searching;
    update();
    await _authService.login(
        loginReqModel: LoginRequestModel(
            username: textEditingNom.text.trim(),
            password: textEditingPassword.text.trim()),
        onLoginSuccess: (data) async {
          textEditingNom.clear();
          textEditingPassword.clear();
          await _localAuth.saveToken(data.access);
          Get.offAllNamed(AppRoutes.HOME);
        },
        onLoginError: (error) {
          if (error.response!.statusCode == 400) {
            CustomSnacbar.showMessage(context, "Le champs nom ou mot de passe ne peut être vide !");
          }
          
          if (error.response!.statusCode == 401) {
            CustomSnacbar.showMessage(context, "Aucun compte actif avec pour nom '${textEditingNom.text}' et mot de passe '${textEditingPassword.text}'");
          }
          print("============ Login =============");
          print("Une erreur est survenue ${error.response!.data}");
          print(error.response!.statusCode);
          print("================================");
          loginStatus = LoadingStatus.failed;
          update();
        });
  }

}