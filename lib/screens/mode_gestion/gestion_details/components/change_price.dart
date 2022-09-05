import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class ChangePrice extends StatelessWidget {
  final dynamic controller;
  const ChangePrice({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 230,
      height: Get.height * 0.64,
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
                title: "Modifier les prix",
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
          Row(
            children: [
              Obx(
                () => Expanded(
                  child: CustomDropDown(
                    helpText: "Taux TVA",
                    controller: controller,
                    liste: controller.tvas,
                    selectedItem: controller.selectedTva.value,
                    onChanged: (data) {
                      controller.onChangeTva(data);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              Obx(
                () => Expanded(
                  child: CustomDropDown(
                    helpText: "Base de prix",
                    controller: controller,
                    liste: controller.baseprix,
                    selectedItem: controller.selectedBasePrix.value,
                    onChanged: (data) {
                      controller.onChangeBasePrix(data);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField2(
            onChanged: (string) {},
            title: "Prix de vente",
            hintText: "Ex: 200",
          ),
          const SizedBox(height: 10),
          CustomTextField2(
            onChanged: (string) {},
            title: "Prix de vente min.",
            hintText: "Ex: 200",
          ),
          const SizedBox(height: kDefaultPadding),
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
