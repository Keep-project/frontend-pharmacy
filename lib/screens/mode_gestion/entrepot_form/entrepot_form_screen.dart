// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/mode_gestion/entrepot_form/entrepot_form.dart';

class EntrepotFormScreen extends GetView<EntrepotFormController> {
  const EntrepotFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<EntrepotFormController>(builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height - 24,
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.2),
            decoration: const BoxDecoration(
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  "assets/images/Symbols.png",
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: kDefaultMargin,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.arrow_left,
                        size: 26, color: kTextColor2),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  const Text(
                    "Ajouter un entrepôt",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  Text(
                    "Un entrepôt désigne ici un  espace où vous désirez conserver vos produit en stock.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 1.2,
                  ),
                  CustomTextField2(
                    controller: controller.textEditingNomEntrepot,
                    onChanged: (string) {},
                    title: "Nom de l'entrepôt",
                    hintText: "Ex: Magasin 01",
                  ),
                  const SizedBox(height: kDefaultPadding/2),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField2(
                          controller: controller.textEditingPays,
                          onChanged: (string) {},
                          title: "Pays",
                          hintText: "Ex: Cameroun",
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: CustomTextField2(
                          controller: controller.textEditingVille,
                          onChanged: (string) {},
                          title: "Ville",
                          hintText: "Ex: Douala",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding /2),
                  CustomTextField2(
                    controller: controller.textEditingTelephone,
                    textInputType: TextInputType.phone,
                    onChanged: (string) {},
                    title: "Téléphone",
                    hintText: "Ex: +237 670000000",
                  ),
                  const SizedBox(height: kDefaultPadding /2),
                  CustomTextField2(
                    controller: controller.textEditingDescription,
                    onChanged: (string) {},
                    title: "Description de l'entrepôt",
                    hintText: "Laissez ici une petite description de votre entrepôt...",
                    maxLines: 3,
                  ),
                  const SizedBox(height: kDefaultPadding * 1.5),
                  InkWell(
                    onTap: () async { 
                      if ( controller.entrepotStatus == LoadingStatus.searching ){ return; }
                      await controller.saveEntrepot(context);
                     },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: kTextColor2,
                        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                      ),
                      child: Center(
                        child: controller.entrepotStatus == LoadingStatus.searching ?
                        const CircularProgressIndicator( color: kWhiteColor) :
                        const Text(
                          "Enregistrer",
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
