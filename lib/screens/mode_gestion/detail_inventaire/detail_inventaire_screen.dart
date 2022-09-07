import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/detail_inventaire/detail_inventaire.dart';

class DetailInventaireScreen extends GetView<DetailInventaireController> {
  const DetailInventaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailInventaireController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, bottom: 5, right: 16),
                  decoration: BoxDecoration(
                    color: kTextColor.withOpacity(0.106),
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius * 3),
                              color: kTextColor2.withOpacity(0.12),
                            ),
                            child: const Text(
                              "Clôturé",
                              style: TextStyle(
                                color: kTextColor2,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      MyRow(
                        title: "Libellé",
                        value: controller.inventaire.libelle!,
                      ),
                      MyRow(
                        title: "Entrepôt",
                        value: controller.inventaire.entrepotName!,
                      ),
                      Text(
                        "Le ${controller.inventaire.createdToString()} à ${controller.inventaire.hourToString()}",
                        style: const TextStyle(
                          color: kTextColor2,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding / 4),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 1.5),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 30,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                          "assets/icons/Icon material-card-giftcard.svg",
                          fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 5),
                    const TitleText(title: "Liste des produits"),
                  ],
                ),
                const SizedBox(height: kDefaultMargin * 1.6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            controller.inventaire.lignesInventaire!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () { Get.toNamed(AppRoutes.DETAILS_GESTION, arguments: controller.inventaire.lignesInventaire![index].medicament!.toString());},
                                child: CardContainer(
                                  header: Row(
                                    children: [
                                      Text(controller.inventaire.lignesInventaire![index].productName!.capitalizeFirst!,
                                        style: TextStyle(
                                          color: kDarkColor.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  body: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      MyRow(
                                        title: "Quantité attendue",
                                        value: controller.inventaire.lignesInventaire![index].quantiteAttendue.toString(),
                                      ),
                                      MyRow(
                                        title: "Quantité réelle",
                                        value: controller.inventaire.lignesInventaire![index].quantiteReelle.toString(),
                                        color: kOrangeColor,
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          InkWell(
                                             onTap: () { Get.toNamed(AppRoutes.MOUVEMENT_PRODUIT, arguments: {'id': controller.inventaire.lignesInventaire![index].medicament!.toString(), 'productName': controller.inventaire.lignesInventaire![index].productName! } ); },
                                            child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: kDefaultPadding / 2,
                                                  vertical: kDefaultPadding / 4),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    kDefaultRadius * 3),
                                                color:
                                                    kTextColor2.withOpacity(0.12),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/icons/Icon map-moving-company.svg",
                                                      height: 10,
                                                      width: 10),
                                                  const SizedBox(width: 3),
                                                  const Text(
                                                    "Mouvements",
                                                    style: TextStyle(
                                                      color: kTextColor2,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: kDefaultPadding / 2),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultMargin * 1.8),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: Center(
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left,
                  color: kWhiteColor, size: 30)),
        ),
      ),
      title: const Text(
        "Détail Inventaires",
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.DASHBORD);
          },
          child: Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: kDefaultMargin * 2),
            decoration: BoxDecoration(
              color: kGreyColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: Icon(CupertinoIcons.person_fill,
                    size: 30, color: kWhiteColor)),
          ),
        ),
      ],
    );
  }
}

class MyRowIcon extends StatelessWidget {
  final String? title;
  final String? value;
  const MyRowIcon({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: TextStyle(
            color: kDarkColor.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            SvgPicture.asset("assets/icons/Composant 54 – 1.svg"),
            const SizedBox(width: 3),
            Text(
              value!,
              style: const TextStyle(
                color: kDarkColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding - 4),
      ],
    );
  }
}
