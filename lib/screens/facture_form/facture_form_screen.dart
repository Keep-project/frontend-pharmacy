// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/details/details_screen.dart';
import 'package:pharmacy_app/screens/facture_form/facture_form.dart';

import '../medicament_form/pages/page_two.dart';

class FactureFormScreen extends GetView<FactureFormController> {
  const FactureFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FactureFormController>(builder: (controller) {
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
                    "Nouvelle facture",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 1.2),
                  Text(
                    "Ici vous enregistrer une nouvelle facture pour une nouvelle commande passée",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kDarkColor.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 1.2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Opacity(
                              opacity: 0.6,
                              child: Text(
                                "Date de facturation",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kDarkColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomIconButton(
                              title: "10/02/2010",
                              iconData: Icons.calendar_month,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: CustomTextField2(
                          onChanged: (string) {},
                          title: "Réduction en %",
                          hintText: "Ex: 0",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CardContainer(
                        header: Row(
                          children: const [
                            Text(
                              "Dolirprane 150mg",
                              style: TextStyle(
                                color: kDarkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Ref: P001",
                              style: TextStyle(
                                color: kDarkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        body: Column(
                          children: [
                            const SizedBox(height: kDefaultPadding / 2),
                            const MyRow(
                              title: "TVA",
                              value: "19.25%",
                            ),
                            const MyRow(
                              title: "Réduction",
                              value: "0%",
                            ),
                            Row(
                              children: [
                                Text(
                                  "Quantité",
                                  style: TextStyle(
                                    color: kDarkColor.withOpacity(0.4),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    CircularButton(
                                      text: '-',
                                      onTap: () {
                                        print("decrement");
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    const Text(
                                      "1",
                                      style: TextStyle(
                                        color: kTextColor2,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    CircularButton(
                                      text: '+',
                                      onTap: () {
                                        print("incremment");
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: const [
                                      Text(
                                        "P.U HT: ",
                                        style: TextStyle(
                                          color: kDarkColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "200 F",
                                        style: TextStyle(
                                          color: kTextColor2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    Row(children: const [
                                      Text(
                                        "Total: ",
                                        style: TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                      Text(
                                        "1200 F",
                                        style: TextStyle(
                                          color: kTextColor2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    print("supprimer le produit");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding * 1.4,
                                        vertical: kDefaultPadding / 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultRadius * 3),
                                      color: kTextColor2.withOpacity(0.12),
                                    ),
                                    child: const Text(
                                      "Supprimer",
                                      style: TextStyle(
                                        color: kTextColor2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultPadding / 2.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  CustomTextField2(
                    onChanged: (string) {},
                    title: "Produit",
                    hintText: "Rechercher le produit...",
                    suffixIcon: InkWell(
                        onTap: () {
                          print("rechercher");
                        },
                        child: Icon(Icons.search,
                            color: kDarkColor.withOpacity(0.4), size: 26)),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Text(
                        "Quantité",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          CircularButton(
                            text: '-',
                            onTap: () {
                              print("decrement");
                            },
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          const Text(
                            "1",
                            style: TextStyle(
                              color: kTextColor2,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          CircularButton(
                            text: '+',
                            onTap: () {
                              print("incremment");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Text(
                        "Montant HT",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "150 F",
                        style: TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      const Spacer(),
                      CustomButton(
                        title: "Ajouter",
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  CustomTextField2(
                    onChanged: (string) {},
                    title: "Note",
                    hintText:
                        "Laissez ici une petite note expliquant cette facture...",
                    maxLines: 3,
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        "Montant total: ",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(0.4),
                        ),
                      ),
                      const Text(
                        "2600 F",
                        style: TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: kTextColor2,
                        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                      ),
                      child: const Center(
                        child: Text(
                          "Enregistrer",
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CircularButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const CircularButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: kWhiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 30,
                color: kTextColor.withOpacity(0.3)),
          ],
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              color: kTextColor2,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
