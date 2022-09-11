// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/models/request_data_models/entrepot_model.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';
import 'package:pharmacy_app/services/remote_services/authentication/authentication.dart';
import 'package:pharmacy_app/services/remote_services/entrepot/entrepot.dart';

class EntrepotFormController extends GetxController {
  final RemoteAuthenticationService _authService =
      RemoteAuthenticationServiceImpl();

  final LocalAuthentificationService _localAuth = LocalAuthentificationServiceImpl();
  LoadingStatus entrepotStatus = LoadingStatus.initial;

  final EntrepotService _entrepotService = EntrepotServiceImpl();

  TextEditingController textEditingNomEntrepot = TextEditingController();
  TextEditingController textEditingPays = TextEditingController();
  TextEditingController textEditingVille = TextEditingController();
  TextEditingController textEditingTelephone = TextEditingController();
  TextEditingController textEditingDescription = TextEditingController();

  saveEntrepot(BuildContext context) async {
    entrepotStatus = LoadingStatus.searching;
    update();

    if (textEditingNomEntrepot.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez le nom de l'entrepôt !");
      return;
    }
    if (textEditingVille.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrer la ville où se trouve votre entrepôt !");
      return;
    }
    if (textEditingPays.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrer le pays où se trouve votre entrepôt !");
      return;
    }

    if (!GetUtils.isPhoneNumber(textEditingTelephone.text.trim())) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrer un contact téléphonique correcte !");
      return;
    }
    if (textEditingDescription.text.trim().isEmpty) {
      CustomSnacbar.showMessage(
          context, "Veuillez entrer une petite description de trouve votre entrepôt !");
      return;
    }

    var idPharmacie = await _localAuth.getPharmacyId();

    EntrepotRequestModel newEntrepot = EntrepotRequestModel(
      nom: textEditingNomEntrepot.text.trim(),
      pays: textEditingPays.text.trim(),
      ville: textEditingVille.text.trim(),
      telephone: textEditingTelephone.text.trim(),
      description: textEditingDescription.text.trim(),
      pharmacie: int.parse(idPharmacie!),
    );

    await _entrepotService.add(
      entrepotModel: newEntrepot,
      onSuccess: (data){
        print(data);
         CustomSnacbar.showMessage(
          context, "Entrepôt crée avec succès !");
          Get.offAndToNamed(AppRoutes.ENTREPOT);
        entrepotStatus = LoadingStatus.completed;
        update();
      },
      onError: (error){
        print("====================================");
        print(error.response);
        print("====================================");
        entrepotStatus = LoadingStatus.failed;
        update();
      }
    );
  }
}
