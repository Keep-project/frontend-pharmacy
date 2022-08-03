// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form.dart';

class MedicamentFormScreen extends GetView<MedicamentFormController> {
  const MedicamentFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MedicamentFormController>(builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height - 24,
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.2),
            decoration: const BoxDecoration(
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  "assets/images/Symbols.png",
                ),
              ),
            ),
            child: SingleChildScrollView(
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
                        size: 26, color: kTextColor2),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  const Text(
                    "Ajouter un médicament",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  Text(
                    "Bien décrire votre médicament aide les clients à comprendre facilement ce qu'il soigne comme maladie.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                      decoration: const BoxDecoration(),
                      height: Get.height * .60,
                      child: PageView.builder(
                        physics: Get.arguments == null
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          // controller.onChangePage(value);
                        },
                        itemCount: controller.pages.length,
                        controller: controller.pageController,
                        itemBuilder: (context, index) =>
                            controller.pages[index],
                      )),
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
                      : controller.step == 1
                          ? InkWell(
                              onTap: () {
                                //await controller.register(context);
                                controller.jumpToStepTwo(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kTextColor2,
                                  borderRadius:
                                      BorderRadius.circular(kDefaultRadius - 2),
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
                          : Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.previousPage();
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        border: Border.all(
                                          width: 1,
                                          color: kTextColor2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius - 2),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Retour",
                                          style: TextStyle(
                                            color: kTextColor2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if ( controller.step == 2 )  {
                                        controller.jumpToStepThree(context);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: kTextColor2,
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius - 2),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.step == 2 ? "Suivant" : "Enregistrer",
                                              style: const TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            controller.step == 2 ? const SizedBox(width: kDefaultPadding) : Container(),
                                            controller.step == 2 ? const Icon(CupertinoIcons.arrow_right,
                                                color: kWhiteColor, size: 26) : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
