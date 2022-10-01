// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pharmacie_form.dart';

class PageThree extends GetView<PharmacieFormScreenController> {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GetBuilder<PharmacieFormScreenController>(
        builder: (controller) => Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kDefaultPadding * 3),
                        const Text(
                            "Vérifiez les informations puis modifier si besoin.",
                            style: TextStyle(
                              color: kTextColor2,
                              fontSize: 18,
                            )),
                        const SizedBox(height: kDefaultPadding * 2),
                        CustomTextField2(
                          onChanged: (string) {},
                          controller: controller.textEditingPays,
                          title: "Pays",
                          hintText: "Ex: Cameroun",
                        ),
                        const SizedBox(height: kDefaultPadding / 1.4),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField2(
                                onChanged: (string) {},
                                controller: controller.textEditingVille,
                                title: "Ville",
                                hintText: "Ex: Yaoundé",
                              ),
                            ),
                            const SizedBox(
                              width: kDefaultPadding,
                            ),
                            Expanded(
                              child: CustomTextField2(
                                onChanged: (string) {},
                                controller: controller.textEditingQuartier,
                                title: "Quartier",
                                hintText: "Ex: Mvan",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding * 3),
                        controller.pharmacieStatus == LoadingStatus.searching
                            ? Container(
                                height: 50,
                                decoration: const BoxDecoration(),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: kTextColor),
                                ))
                            : Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.previousPage();
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          border: Border.all(
                                            width: 1,
                                            color: kTextColor2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              kDefaultRadius - 2),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Retour",
                                            style: TextStyle(
                                              color: kTextColor2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: kDefaultPadding),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        if (controller.step == 2) {
                                          await controller.addPharmacy(context);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: kTextColor2,
                                          borderRadius: BorderRadius.circular(
                                              kDefaultRadius - 2),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "Enregistrer",
                                                style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: kDefaultPadding),
                                              Icon(CupertinoIcons.arrow_right,
                                                  color: kWhiteColor, size: 26),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ]),
                ),
              ],
            ));
  }
}
