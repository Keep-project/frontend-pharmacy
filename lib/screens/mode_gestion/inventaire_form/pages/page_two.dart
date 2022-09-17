import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire_form/inventaire_form.dart';

class PageTwo extends GetView<InventaireFormController> {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventaireFormController>(
        builder: (controller) => Container(
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kDefaultPadding / 2),
                ...List.generate(
                  controller.lignesProduits.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CardContainer(
                      header: Row(children: [
                        Text(
                          controller
                              .lignesProduits[index].nom!.capitalizeFirst!,
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          controller.lignesProduits[index].id!
                              .toString()
                              .padLeft(2, '0'),
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                      body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: kDefaultPadding / 2),
                            MyRow(
                              title: "Stock limite pour alert",
                              value: controller
                                  .lignesProduits[index].stockAlert!
                                  .toString()
                                  .padLeft(2, '0'),
                              color: kOrangeColor,
                            ),
                            MyRow(
                              title: "Stock désiré optimal",
                              value: controller
                                  .lignesProduits[index].stockOptimal!
                                  .toString()
                                  .padLeft(2, '0'),
                            ),
                            MyRow(
                              title: "Stock attendu",
                              value: controller
                                  .lignesProduits[index].stockAttendu!
                                  .toString()
                                  .padLeft(2, '0'),
                            ),
                            MyRow(
                              title: "Stock réel",
                              value: controller
                                  .lignesProduits[index].stockReel!
                                  .toString()
                                  .padLeft(2, '0'),
                            ),
                            
                            const SizedBox(height: kDefaultPadding / 2),
                            Row(
                              children: [
                                Row(children: [
                                  const Text(
                                    "Total: ",
                                    style: TextStyle(
                                      color: kDarkColor,
                                    ),
                                  ),
                                  Text(
                                    "${controller.lignesProduits[index].prix} F",
                                    style: const TextStyle(
                                      color: kTextColor2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
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
                                  child: InkWell(
                                    onTap: () {
                                      controller.lignesProduits
                                          .removeAt(index);
                                      controller.update();
                                    },
                                    child: const Text(
                                      "Supprimer",
                                      style: TextStyle(
                                        color: kTextColor2,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultPadding / 2)
                          ]),
                    ),
                  ),
                ),
                CustomTextField2(
                  controller: controller.searchController,
                  onChanged: (data) async {
                    await controller.searchData(data);
                  },
                  title: "",
                  hintText: "Rechercher un produit...",
                  suffixIcon: InkWell(
                      onTap: () {},
                      child: Icon(Icons.search,
                          color: kDarkColor.withOpacity(0.4), size: 26)),
                ),
                const SizedBox(height: kDefaultPadding - 4),
                Row(
                  children: [
                    const TitleText(title: "Produits en stock"),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Terminer",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Column(
                  children: [
                    ...List.generate(
                      controller.medicamentsList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CardContainer(
                          header: Row(children: [
                            Text(
                              controller.medicamentsList[index].nom!
                                  .capitalizeFirst!,
                              style: TextStyle(
                                color: kDarkColor.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              controller.medicamentsList[index].id!
                                  .toString()
                                  .padLeft(2, '0'),
                              style: TextStyle(
                                color: kDarkColor.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                          body: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: kDefaultPadding / 2),
                                MyRow(
                                  title: "Stock limite pour alert",
                                  value: controller
                                      .medicamentsList[index].stockAlert!
                                      .toString()
                                      .padLeft(2, '0'),
                                  color: kOrangeColor,
                                ),
                                MyRow(
                                  title: "Stock désiré optimal",
                                  value: controller
                                      .medicamentsList[index].stockOptimal!
                                      .toString()
                                      .padLeft(2, '0'),
                                ),
                                MyRow(
                                  title: "Stock attendu",
                                  value: controller
                                      .medicamentsList[index].stock!
                                      .toString()
                                      .padLeft(2, '0'),
                                ),
                                Row(children: [
                                  Text("Stock réel",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              kDarkColor.withOpacity(0.7))),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      controller.medicamentsList[index]
                                                  .stock! <=
                                              controller
                                                  .medicamentsList[index]
                                                  .stockAlert!
                                          ? SvgPicture.asset(
                                              "assets/icons/Composant 54 – 1.svg",
                                              height: 18,
                                              width: 18)
                                          : Container(),
                                      const SizedBox(width: 3),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color:
                                              kDarkColor.withOpacity(0.04),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  kDefaultRadius / 2),
                                        ),
                                        child: TextField(
                                          keyboardType:
                                              TextInputType.number,
                                          onChanged: (string) {
                                            controller.quantiteReelle =
                                                string;
                                          },
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              hintText: "0",
                                              contentPadding:
                                                  EdgeInsets.only(
                                                      left: 5, top: 7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                const SizedBox(height: kDefaultPadding / 2),
                                Row(
                                  children: [
                                    Row(children: [
                                      const Text(
                                        "Total: ",
                                        style: TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                      Text(
                                        "${controller.medicamentsList[index].prix} F",
                                        style: const TextStyle(
                                          color: kTextColor2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "enregistrer les modifications");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: kDefaultPadding / 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  kDefaultRadius * 3),
                                          color:
                                              kTextColor2.withOpacity(0.12),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            controller.addLigneProduit(
                                                controller.medicamentsList[
                                                    index]);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/Tracé 27.svg",
                                                  height: 12,
                                                  width: 14),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "Enregistrer",
                                                style: TextStyle(
                                                  color: kTextColor2,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 2)
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    controller.inventaireStatus == LoadingStatus.searching
                        ? Container(
                            height: 45,
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kTextColor2,
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
                                  onTap: () async {
                                    await controller.save(context);
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
                                        children: const [
                                          Text(
                                            "Terminer",
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
                              )
                            ],
                          ),
                    const SizedBox(height: kDefaultPadding),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
