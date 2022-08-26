
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/home/components/custom_button.dart';
import 'package:pharmacy_app/screens/home/components/custom_checkbox.dart';

class FilterDialog extends StatelessWidget {
  final dynamic controller;
  const FilterDialog({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius)),
      alignment: Alignment.topRight,
      child: Container(
        height: 420,
        width: 300,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filtre",
              style: TextStyle(
                fontSize: 20,
                color: kTextColor2,
                fontWeight: FontWeight.w600,
              ),
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
            const SizedBox(height: kDefaultMargin),
            GestureDetector(
              onTap: () async {
                await controller.filterMedicamentsList(key: "filter");
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
    );
  }
}
