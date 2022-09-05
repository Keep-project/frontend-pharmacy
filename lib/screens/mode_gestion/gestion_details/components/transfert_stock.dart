import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class TransfertStock extends StatelessWidget {
  final dynamic controller;
  const TransfertStock({
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
          Row(
            children: [
              const TitleText(
                title: "Transférer un stock",
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
          const SizedBox(height: kDefaultPadding - 4),
          Obx(
            () => CustomDropDown(
              helpText: "Entrepôt source",
              controller: controller,
              liste: controller.entrepots,
              selectedItem: controller.selectedEntrepotSource.value,
              onChanged: (data) {
                controller.onChangeEntrepotSource(data);
              },
            ),
          ),
          Obx(
            () => CustomDropDown(
              helpText: "Entrepôt destination",
              controller: controller,
              liste: controller.entrepots,
              selectedItem: controller.selectedEntrepotDestination.value,
              onChanged: (data) {
                controller.onChangeEntrepotDestination(data);
              },
            ),
          ),
          const SizedBox(height: 10),
          CustomTextField2(
            onChanged: (string) {},
            title: "Nombre de pièces",
            hintText: "Ex: 200",
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          CustomTextField2(
            onChanged: (string) {},
            title: "Libellé du mouvement",
            hintText: "Transfert du stock du produit 1 dans un autre entrepôt",
            maxLines: 3,
          ),
          const SizedBox(height: kDefaultPadding / 2),
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
              CustomButton(
                title: "Enregistrer",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}