// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_snackbar.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/custom_button.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/custom_checkbox.dart';

class FilterDialog extends StatelessWidget {
  final dynamic controller;
  const FilterDialog({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: kWhiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)),
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.all(0),
        child: Container(
          height: Get.height,  // 540,
          width: Get.width,  // 400,
          padding: const EdgeInsets.all(kDefaultPadding-4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:[
                  const Text(
                    "Filtres",
                    style: TextStyle(
                      fontSize: 18,
                      color: kTextColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () { Get.back();},
                    child: Icon(Icons.close, size: 26, color: kDarkColor.withOpacity(0.5)),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultMargin / 2),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(height: kDefaultMargin * 1.5),
              Text(
                "catégorie",
                style: TextStyle(
                  color: kTextColor2.withOpacity(.6),
                ),
              ),
              const SizedBox(height: kDefaultMargin * 1.5),
              Obx(
                () => Wrap(
                  runSpacing: 16,
                  spacing: 20,
                  children: [
                    ...List.generate(
                        controller.categories.length,
                        (index) => CustomButton(
                            onTap: () async {
                              Get.back();
                              await controller.changeSelectedCategory(index);
                            },
                            libelle: controller.categories[index]['libelle'],
                            color:
                                index == controller.selectedCategorieIndex.value
                                    ? kWhiteColor
                                    : kTextColor2,
                            backgroundColor:
                                index == controller.selectedCategorieIndex.value
                                    ? kTextColor2
                                    : kWhiteColor))
                  ],
                ),
              ),
              const SizedBox(height: kDefaultMargin),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(height: kDefaultMargin - 4),
              Text(
                "voie de prise",
                style: TextStyle(
                  color: kTextColor2.withOpacity(.6),
                ),
              ),
              const SizedBox(height: kDefaultPadding / 6),
              Wrap(
                runSpacing: 0,
                spacing: 0,
                children: [
                  ...List.generate(controller.voix.length, (index) {
                    return CheckBoxComponent(
                        controller: controller, index: index);
                  }),
                ],
              ),
              const SizedBox(height: kDefaultMargin / 2),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(height: kDefaultMargin - 4),
              Text(
                "Saisir votre rayon de recherche (en K.M)",
                style: TextStyle(
                  color: kTextColor2.withOpacity(.6),
                ),
              ),
              const SizedBox(height: kDefaultMargin * 1.5),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: kTextColor2,
                  ),
                  borderRadius: BorderRadius.circular(kDefaultRadius / 2),
                ),
                child: TextField(
                  onChanged: (String value) async {
                    if (value.isNotEmpty) {
                      try {
                        controller.distance = double.parse(value.trim());
                      } catch (e) {
                        Get.back();
                        CustomSnacbar.showMessage(context, "Veuillez saisir une valeur correcte !!");
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Ex: 5",
                      contentPadding: EdgeInsets.only(
                          left: 10, top: 3, bottom: 8, right: 10)),
                ),
              ),
              const SizedBox(height: kDefaultMargin * 1.5),
              const SizedBox(height: kDefaultMargin),
              GestureDetector(
                onTap: () async {
                  await controller.filterMedicamentsList();
                  Get.back();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: kTextColor2,
                    border: Border.all(
                      width: 1.2,
                      color: kTextColor2,
                    ),
                    borderRadius: BorderRadius.circular(kDefaultRadius - 4),
                  ),
                  child: const Center(
                    child: Text(
                      'Rechercher',
                      style: TextStyle(
                        fontSize: 16,
                        color: kWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
