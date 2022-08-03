// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form.dart';

class MedicamentFormScreen extends GetView<MedicamentFormController> {
  const MedicamentFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MedicamentFormController>(builder: (controller) {
        return Scaffold(
          
          body: SingleChildScrollView(
            child: Container(
              height: Get.height - 24,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding  *1.2),
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
                        size: 36, color: kTextColor2),
                  ),
                  const Spacer(),
                  const Text(
                    "Ajouter un médicament",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  Text(
                    "Bien décrire votre médicament aide les clients à comprendre facilement ce qu'il soigne comme maladie.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  CustomTextField2(
                    onChanged: (string){},
                    title: "Entrez le nom",
                    hintText: "EX: Doliprane 200mg",
                  ),
                  const SizedBox(height: kDefaultPadding * 1.5),
                  const Spacer(),
                  controller.registerStatus == LoadingStatus.searching
                      ? Container(
                          height: 45,
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kOrangeColor,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async  {
                            await controller.register(context);
                          },  
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kTextColor2,
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius - 2),
                            ),
                            child: const Center(
                              child: Text(
                                "Enregistrer",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
