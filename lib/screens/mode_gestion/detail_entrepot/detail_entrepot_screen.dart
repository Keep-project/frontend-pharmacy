// ignore_for_file: avoid_print

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
import 'package:pharmacy_app/screens/mode_gestion/detail_entrepot/detail_entrepot_controller.dart';

class DetailEntrepotScreen extends GetView<DetailEntrepotController> {
  const DetailEntrepotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailEntrepotController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            height: Get.height,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Produits uniques",
                                    style: TextStyle(
                                      color: kDarkColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "2",
                                    style: TextStyle(
                                      color: kOrangeColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quantité",
                                    style: TextStyle(
                                      color: kDarkColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "18",
                                    style: TextStyle(
                                      color: kOrangeColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Valeur à la vente",
                                    style: TextStyle(
                                      color: kDarkColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "5700 F",
                                    style: TextStyle(
                                      color: kOrangeColor.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dernier mouvement",
                                  style: TextStyle(
                                    color: kDarkColor.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Le 10/03/2016",
                                  style: TextStyle(
                                    color: kDarkColor.withOpacity(0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Mouvements",
                                style: TextStyle(
                                  color: kTextColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.room, color: kOrangeColor, size: 18),
                          Text(
                            "Cameroun/Yaoundé",
                            style: TextStyle(
                              color: kTextColor2,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          "Tel: 652310829",
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const TitleText(title: "Description"),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(
                    "Ce magasin a été crée pour stock nos produits pharmaceutiques de première nécessité. Bien décrire votre entrepôt vous permet de connaitre rapidement ce qui peut ou non être stocker à l'intérieur à tout moment.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.76),
                      height: 1.2,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const TitleText(title: "Liste des produits"),
                  const SizedBox(height: kDefaultPadding - 4),
                  ...List.generate(10, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: CardContainer(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Paracétamol",
                                style: TextStyle(
                                  color: kDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Référence: P018",
                                style: TextStyle(
                                  color: kDarkColor.withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<dynamic>(
                            icon: Icon(Icons.more_vert, color: kDarkColor.withOpacity(0.8), size: 22),
                            onSelected: (value) {
                              print(value);
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/Icon map-moving-company.svg", height: 14, width: 11),
                                    const SizedBox(width: 5),
                                    const Text("Transférer le stock"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/Tracé 27.svg", height: 14, width: 11),
                                    const SizedBox(width: 5),
                                    const Text("Corriger le stock"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      body: Column(
                        children: const [
                          MyRow(title: "Nombre de pièces", value: "10"),
                          MyRow(
                              title: "Prix moyen pondéré (PMP)",
                              value: "200 F"),
                          MyRow(title: "Valorisation achat", value: "2000 F"),
                          MyRow(
                              title: "Prix de vente unitaire", value: "250 F"),
                          MyRow(title: "Valeur à la vente", value: "2500 F", color: kOrangeColor),
                        ],
                      ),
                    ),
                  ),),
                  const SizedBox(height: 60),
                ],
              ),
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
        "Détail magasin 01",
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
