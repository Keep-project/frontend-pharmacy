import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/medicament_form.dart';

class PageOne extends GetView<MedicamentFormController> {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicamentFormController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: kDefaultPadding * 1.2),
                CustomTextField2(
                  onChanged: (string) {},
                  controller: controller.textEditingNom,
                  title: "Entrez le nom",
                  hintText: "Ex: Doliprane 200mg",
                ),
                const SizedBox(height: kDefaultPadding / 1.4),
                CustomDropDown(
                  helpText: "Catégorie du produit",
                  controller: controller,
                  liste: controller.categories,
                  selectedItem: controller.selectedCategorie,
                  onChanged: (data) {
                    controller.onChangeCategorie(data);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        textInputType: TextInputType.number,
                        onChanged: (string) {},
                        controller: controller.textEditingPrixVente,
                        title: "Prix de vente en fcfa",
                        hintText: "Ex: 3000",
                      ),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: CustomTextField2(
                        onChanged: (string) {},
                        title: "Marque",
                        controller: controller.textEditingMarque,
                        hintText: "Ex: Denk",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        onChanged: (string) {},
                        controller: controller.textEditingMasseUnite,
                        title: "Masse d'unité",
                        hintText: "Ex: 3000g",
                      ),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: CustomTextField2(
                        textInputType: TextInputType.number,
                        onChanged: (string) {},
                        controller: controller.textEditingStock,
                        title: "Quantité à stocker",
                        hintText: "Ex: 180",
                      ),
                    ),
                  ],
                ),
                
              ],
            ));
  }
}
