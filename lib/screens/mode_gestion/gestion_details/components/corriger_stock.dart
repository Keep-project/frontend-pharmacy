import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';

class CorrigerStock extends StatelessWidget {
  final dynamic controller;
  const CorrigerStock({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 230,
      height: Get.height * 0.73,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding *1.5),
          Row(
            children: [
              const TitleText(
                title: "Corriger le stock",
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close,
                      color: kDarkColor.withOpacity(0.3), size: 26)),
            ],
          ),
          const Divider(
            thickness: 1.2,
          ),
          const SizedBox(height: kDefaultPadding),
          Text("Entrez la quantite la quantité que vous désirez augmenter ou diminuer de votre stock et choisir l'action correspondante.",
            style: TextStyle(
              height: 1.5,
              fontSize: 16,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          /*Obx(
            () => CustomDropDown(
              helpText: "Entrepôt",
              controller: controller,
              liste: controller.entrepots,
              selectedItem: controller.selectedEntrepotDestination.value,
              onChanged: (data) {
                controller.onChangeEntrepotDestination(data);
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),*/
          Row(
            children: [
              Expanded(
                child: CustomTextField2(
                  onChanged: (string) {},
                  title: "Nombre de pièces",
                  hintText: "Ex: 200",
                  textInputType: TextInputType.number,
                  controller: controller.textEditingNewStock,
                ),
              ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              Obx(
                () => Expanded(
                  child: CustomDropDown(
                    helpText: " ",
                    controller: controller,
                    liste: controller.actions,
                    selectedItem: controller.selectedAction.value,
                    onChanged: (data) {
                      controller.onChangeAction(data);
                    },
                  ),
                ),
              ),
            ],
          ),
          /*const SizedBox(height: 8),
          CustomTextField2(
            onChanged: (string) {},
            title: "Prix unitaire de vente en fcfa",
            hintText: "Ex: 200",
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          CustomTextField2(
            onChanged: (string) {},
            title: "Libellé du mouvement",
            hintText: "Correction du stock du produit: Paracétamol 200mg",
            maxLines: 3,
          ),*/
          const SizedBox(height: kDefaultPadding *3),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Annuler",
                  style: TextStyle(
                    color: kTextColor2.withOpacity(0.5),
                  ),
                ),
              ),
              const Spacer(),
             controller.medicamentStatus == LoadingStatus.searching ?
                Container(
                  height: 40,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: kTextColor2,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(color: kWhiteColor)
                  ),
                ) :
                CustomButton(
                  title: "Enregistrer",
                  onTap: () async { await controller.updateStock(context); },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
