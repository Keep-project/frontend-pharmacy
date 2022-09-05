import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_icon_button.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pharmacie_form.dart';

class PageOne extends GetView<PharmacieFormScreenController> {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PharmacieFormScreenController>(
        builder: (controller) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kDefaultMargin,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.arrow_left,
                        size: 26, color: kTextColor2),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  const Text(
                    "Ajouter une pharmacie",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  Text(
                    "Bien reférencer votre pharmacie aide les clients à facilement entrer en contact avec vous et à suivre votre activité.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  CustomTextField2(
                    onChanged: (string) {},
                    controller: controller.textEditingNom,
                    title: "Nom",
                    hintText: "Ex: Pharmacie du soleil",
                  ),
                  const SizedBox(height: kDefaultPadding / 1.4),
                  CustomTextField2(
                    onChanged: (string) {},
                    controller: controller.textEditingEmail,
                    title: "Email",
                    hintText: "Ex: pharmaciedusoleil@gmail.com",
                  ),
                  const SizedBox(height: kDefaultPadding / 1.4),
                  CustomTextField2(
                    onChanged: (string) {},
                    controller: controller.textEditingPhone,
                    title: "Contact téléphonique",
                    hintText: "Ex: +237 652 310 829",
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Opacity(
                              opacity: 0.6,
                              child: Text(
                                "Heure ouverture",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kDarkColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomIconButton(
                              title: controller.ouverture.format(context),
                              iconData: Icons.timer,
                              onTap: () { controller.getOpenTimePicker(context);},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Opacity(
                              opacity: 0.6,
                              child: Text(
                                "Heure fermeture",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kDarkColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomIconButton(
                              title: controller.fermeture.format(context),
                              iconData: Icons.timer,
                              onTap: () { controller.getCloseTimePicker(context);},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding *1.5),
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
                  ),
                ],
              ),
            ));
  }
}
