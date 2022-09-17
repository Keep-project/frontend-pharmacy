import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire_form/inventaire_form.dart';

class PageOne extends GetView<InventaireFormController> {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventaireFormController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
                children: [
                  const SizedBox(height: kDefaultPadding * 1.8),
                  CustomTextField2(
                    onChanged: (string) {},
                    title: "Libelle de l'inventaire",
                    hintText: "Ex: Inventaire sur Doliprane 200mg",
                    controller: controller.textEditingLibelle,
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  CustomDropDown(
                    helpText: "Selectionnez l'entrepôt",
                    controller: controller,
                    liste: controller.entrepots,
                    selectedItem: controller.selectedEntrepot,
                    onChanged: (data) {
                      controller.onChangeEntrepot(data);
                    },
                  ),
                  const SizedBox(height: kDefaultPadding * 3),
                  InkWell(
                    onTap: () {
                      controller.jumpToStepTwo(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: kTextColor2,
                        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Suivant",
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
                  )
                ],
              ),
        ));
  }
}
