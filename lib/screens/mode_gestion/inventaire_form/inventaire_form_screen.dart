// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire_form/inventaire_form.dart';

class InventaireFormScreen extends GetView<InventaireFormController> {
  const InventaireFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<InventaireFormController>(builder: (controller) {
        return Scaffold(
          body: Container(
            //height: Get.height - 24,
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
                  "Créer une fiche d'inventaire",
                  style: TextStyle(
                    color: kTextColor2,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 1.2),
                Text(
                  "La fiche d'inventaire vous permet de faire un recensement rapide des stocks de vos entrepôts en quelques étapes juste.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kDarkColor.withOpacity(0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(),
                      height: Get.height,
                      child: PageView.builder(
                        physics: Get.arguments == null
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        onPageChanged: (value) {},
                        itemCount: controller.pages.length,
                        controller: controller.pageController,
                        itemBuilder: (context, index) =>
                            controller.pages[index],
                      )),
                ),
                
              ],
            ),
          ),
        );
      }),
    );
  }
}
