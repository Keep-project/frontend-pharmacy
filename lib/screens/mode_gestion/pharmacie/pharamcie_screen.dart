import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie/pharmacie.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';

class PharmacieScreen extends GetView<PharmacieScreenController> {
  const PharmacieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PharmacieScreenController>(
          builder: (controller) => Scaffold(
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            decoration: const BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: kDefaultPadding,
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset("assets/images/logo.png"),
                                  ),
                                ),
                                const SizedBox(height: kDefaultPadding * 2),
                                Text(
                                  "Bien vouloir sélectionner la pharmacie avec laquelle vous souhaitez continuer votre activité",
                                  style: TextStyle(
                                    color: kDarkColor.withOpacity(.8),
                                    fontSize: 17,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: kDefaultPadding),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: Wrap(
                            spacing: kDefaultPadding,
                            runSpacing: kDefaultPadding,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.PHARMACIEFORM);
                                },
                                child: Container(
                                    height: 200,
                                    width: Get.width / 2 - 30,
                                    decoration: BoxDecoration(
                                      color: kTextColor2.withOpacity(.08),
                                      borderRadius: BorderRadius.circular(
                                          kDefaultPadding),
                                    ),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(kDefaultPadding),
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        children: [
                                          const Spacer(flex: 2),
                                          Text(
                                            "Ajouter une pharmacie",
                                            style: TextStyle(
                                              color:
                                                  kTextColor2.withOpacity(0.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(children: [
                                            const Spacer(),
                                            Icon(CupertinoIcons.plus_circle,
                                                size: 36,
                                                color:
                                                    kDarkColor.withOpacity(.7)),
                                          ]),
                                          const Spacer(
                                            flex: 2,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              ...List.generate(
                                controller.pharmaciesList.length,
                                (index) => GestureDetector(
                                  onTap: () async {
                                    final LocalAuthentificationService
                                        _localAuth =
                                        LocalAuthentificationServiceImpl();
                                    await _localAuth.savePharmacyId(controller
                                        .pharmaciesList[index].id
                                        .toString());
                                    Get.toNamed(AppRoutes.STOCK);
                                  },
                                  child: Container(
                                      height: 200,
                                      width: Get.width / 2 - 30,
                                      decoration: BoxDecoration(
                                        color: kTextColor2.withOpacity(.08),
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          children: [
                                            const Spacer(flex: 2),
                                            Text(
                                              controller
                                                  .pharmaciesList[index].nom!
                                                  .toString()
                                                  .capitalizeFirst!,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: kTextColor2
                                                    .withOpacity(0.7),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                                height: kDefaultPadding / 2),
                                            Text(
                                              "Ouvre de ${controller.pharmaciesList[index].ouverture} à ${controller.pharmaciesList[index].fermeture}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    kDarkColor.withOpacity(0.5),
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(children: [
                                              const Spacer(),
                                              Icon(CupertinoIcons.arrow_right,
                                                  size: 26,
                                                  color: kDarkColor
                                                      .withOpacity(.7)),
                                            ]),
                                            const Spacer(
                                              flex: 2,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              controller.pharmacyStatus ==
                                      LoadingStatus.searching
                                  ? Container(
                                      height: 200,
                                      width: Get.width / 2 - 30,
                                      decoration: const BoxDecoration(),
                                      child: const Center(
                                          child: CircularProgressIndicator(
                                              color: kTextColor)),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
