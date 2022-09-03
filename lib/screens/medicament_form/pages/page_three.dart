import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form.dart';

class PageThree extends GetView<MedicamentFormController> {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicamentFormController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: kDefaultPadding * 1.2),
                CustomTextField2(
                  onChanged: (string) {},
                  controller: controller.textEditingDescription,
                  title: "Description du produit",
                  hintText: "Entrez la description de votre produit ici...",
                  maxLines: 5,
                ),
                const SizedBox(height: kDefaultPadding / 1.4),
                CustomTextField2(
                  onChanged: (string) {},
                  controller: controller.textEditingPosologie,
                  title: "Posologie",
                  hintText: "Entrez la posologie de votre produit ici...",
                  maxLines: 4,
                ),
              ],
            ));
  }
}
