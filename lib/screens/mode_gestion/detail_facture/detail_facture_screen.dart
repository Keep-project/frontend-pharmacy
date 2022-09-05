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
import 'package:pharmacy_app/screens/mode_gestion/detail_facture/detail_facture.dart';

class DetailFactureScreen extends GetView<DetailFactureController> {
  const DetailFactureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailFactureController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Container());
              },
              backgroundColor: kTextColor2,
              child: const Icon(Icons.add, color: kWhiteColor, size: 36)),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: kDefaultPadding),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, bottom: 5, right: 16),
                            decoration: BoxDecoration(
                              color: kTextColor.withOpacity(0.106),
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Montant HT",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "6000 F",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Montant TVA",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "1155 F",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Montant TTC",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "7155 F",
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 3),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Le 10/08/2004 14h02",
                                      style: TextStyle(
                                        color: kTextColor2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                          vertical: kDefaultPadding / 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius * 3),
                                        color: kTextColor2.withOpacity(0.12),
                                      ),
                                      child: const Text(
                                        "Payée",
                                        style: TextStyle(
                                          color: kTextColor2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 2.3),
                                const MyRow(
                                    title: "Référence", value: "FAC200-003"),
                                const MyRow(
                                    title: "Auteur", value: "Super Admin"),
                                const MyRow(
                                    title: "Type", value: "Facture standard"),
                                const MyRow(title: "Réduction", value: "0%"),
                                const MyRow(
                                  title: "Date d'échéance",
                                  value: "13/08/2004",
                                  color: kOrangeColor,
                                ),
                                const MyRow(
                                    title: "Méthode de paiement",
                                    value: "Espèce"),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          const TitleText(title: "Lignes de produits"),
                          const SizedBox(height: kDefaultPadding - 4),
                          ...List.generate(
                            10,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CardContainer(
                                header: Row(
                                  children: [
                                    Text(
                                      "Inventaire sur Paracétamol 0$index",
                                      style: TextStyle(
                                        color: kDarkColor.withOpacity(0.9),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Ref: INV01",
                                      style: TextStyle(
                                        color: kDarkColor.withOpacity(0.9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                body: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    const MyRow(
                                      title: "TVA",
                                      value: "19.25%",
                                    ),
                                    const MyRow(
                                      title: "P.U HT",
                                      value: "150 F",
                                    ),
                                    const MyRow(
                                      title: "Quantité",
                                      value: "12",
                                    ),
                                    const MyRow(
                                      title: "Réduction",
                                      value: "0%",
                                    ),
                                    const MyRow(
                                      title: "Total HT",
                                      value: "1200 F",
                                      color: kOrangeColor,
                                    ),
                                    Container(),
                                    const SizedBox(height: kDefaultPadding / 2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultMargin * 1.6),
                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 30,
                                decoration: const BoxDecoration(),
                                child: SvgPicture.asset(
                                    "assets/icons/money-check-alt.svg",
                                    fit: BoxFit.fill),
                              ),
                              const SizedBox(width: 5),
                              const TitleText(
                                  title: "Règlements reçu"),
                            ],
                          ),
                          const SizedBox(height: kDefaultMargin),
                          ...List.generate(
                            2,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CardContainer(
                                header: Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/Icon feather-download.svg",
                                            height: 18,
                                            width: 18),
                                        const SizedBox(width: 5),
                                        Text(
                                          "FAC2022-00$index",
                                          style: TextStyle(
                                            color: kDarkColor.withOpacity(0.9),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payé le 12/03/2002",
                                          style: TextStyle(
                                            color: kDarkColor.withOpacity(0.9),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Par: Super Admin",
                                          style: TextStyle(
                                            color: kDarkColor.withOpacity(0.4),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                body: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    const MyRow(
                                      title: "Montant HT",
                                      value: "4000 F",
                                    ),
                                    const MyRow(
                                      title: "Montant TTC",
                                      value: "4770 F",
                                    ),
                                    const MyRow(
                                      title: "Date d'échéance",
                                      value: "13/03/2002",
                                      color: kOrangeColor,
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
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
        "Détail FAC2022-001",
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
