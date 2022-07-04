// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/register_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';

class RegisterScreenController extends GetxController{
  
final RemoteAuthenticationService _authService = RemoteAuthenticationServiceImpl();
final TextEditingController textEditingNom = TextEditingController();
final TextEditingController textEditingEmail = TextEditingController();
final TextEditingController textEditingPassword = TextEditingController();
LoadingStatus registerStatus = LoadingStatus.initial;

bool obscureText = true;

  @override
  void dispose() {
    textEditingNom.dispose();
    textEditingEmail.dispose();
    textEditingPassword.dispose();
    super.dispose();
  }

  Future register(BuildContext context) async {
    if (textEditingNom.text.trim().toString().length < 4 && textEditingPassword.text.trim().toString().length < 8){
      CustomSnacbar.showMessage(context, "Le champs nom doit avoir au moins 04 caractères et le champs mot de passe au moins 08 caractères !");
      return;
    }
    if (textEditingNom.text.trim().toString().length < 4){
      CustomSnacbar.showMessage(context, "Le champs nom doit avoir au moins 04 caractères !");
      return;
    }
    if (textEditingPassword.text.trim().toString().length < 8){
      CustomSnacbar.showMessage(context, "Le champs mot de passe doit avoir au moins 08 caractères !");
      return;
    }
    if (textEditingEmail.text.trim().toString().length < 10){
      CustomSnacbar.showMessage(context, "Veuillez entrez une adresse mail correcte !");
      return;
    }
    registerStatus = LoadingStatus.searching;
    update();
    await _authService.register(
      registerReqModel: RegisterRequestModel(
        username: textEditingNom.text.trim(),
        email: textEditingEmail.text.trim(),
        password: textEditingPassword.text.trim(),
      ),
      onRegisterSuccess: (data){
        CustomSnacbar.showMessage(context, "Compte créer avec succès !\nConnectez vous maintenant.");
        Get.offAndToNamed(AppRoutes.LOGIN);
        registerStatus = LoadingStatus.completed;
        update();
      },
      onRegisterError: (error){
        print("============ Register ===========");
        print(error.response!.statusCode);
        if (error.response!.statusCode == 400) {
            CustomSnacbar.showMessage(context, "${error.response!.data['message']}");
        }
        print("=================================");
        registerStatus = LoadingStatus.failed;
        update();
      },
    );
  }
}