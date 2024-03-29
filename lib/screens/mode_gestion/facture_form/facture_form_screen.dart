// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/custom_icon_button.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/screens/mode_gestion/facture_form/facture_form.dart';

class FactureFormScreen extends GetView<FactureFormController> {
  const FactureFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

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
                    "Ici vous enregistrez une nouvelle facture pour une nouvelle commande passée",
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
                              title: controller.dateFacturationToString,
                              iconData: Icons.calendar_month,
                              onTap: () async {
                                DateTime? newdate = await showDatePicker(
                                  context: context,
                                  initialDate: controller.dateFacturation,
                                  firstDate: DateTime(
                                      controller.dateFacturation.year - 10),
                                  lastDate: DateTime(
                                      controller.dateFacturation.year + 10),
                                );
                                if (newdate == null) {
                                  return;
                                }
                                controller.dateFacturationToString =
                                    "${newdate.day.toString().padLeft(2, '0')}/${newdate.month.toString().padLeft(2, '0')}/${newdate.year}";
                                controller.dateFacturation = newdate;

                                controller.update();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: CustomTextField2(
                          controller: controller.textEditingReduction,
                          onChanged: (string) {},
                          title: "Réduction en %",
                          hintText: "Ex: 0",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  ...List.generate(
                    controller.lignesProduits.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CardContainer(
                        header: Row(
                          children: [
                            Text(
                              controller
                                  .lignesProduits[index].nom!.capitalizeFirst!,
                              style: const TextStyle(
                                color: kDarkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Ref: ${controller.lignesProduits[index].id!.toString().padLeft(2, '0')}",
                              style: const TextStyle(
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
                            Row(
                              children: [
                                Text(
                                  "Quantité",
                                  style: TextStyle(
                                    color: kDarkColor.withOpacity(0.6),
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
                                        if (controller.lignesProduits[index]
                                                .quantite! <=
                                            1) {
                                          return;
                                        }
                                        controller.lignesProduits[index]
                                            .quantite = controller
                                                .lignesProduits[index]
                                                .quantite! -
                                            1;
                                        controller.update();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    Text(
                                      controller.lignesProduits[index].quantite!
                                          .toString(),
                                      style: const TextStyle(
                                        color: kTextColor2,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    CircularButton(
                                      text: '+',
                                      onTap: () {
                                        if (controller
                                                .lignesProduits[index].stock! ==
                                            controller.lignesProduits[index]
                                                .quantite!) {
                                          controller.showMessage(
                                              context,
                                              controller
                                                  .lignesProduits[index].nom!);
                                          return;
                                        }
                                        controller.lignesProduits[index]
                                            .quantite = controller
                                                .lignesProduits[index]
                                                .quantite! +
                                            1;
                                        controller.update();
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
                                    Row(children: [
                                      const Text(
                                        "P.U HT: ",
                                        style: TextStyle(
                                          color: kDarkColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        "${controller.lignesProduits[index].prix!} F",
                                        style: const TextStyle(
                                          color: kTextColor2,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    Row(children: [
                                      const Text(
                                        "Total: ",
                                        style: TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                      Text(
                                        "${controller.lignesProduits[index].prix! * controller.lignesProduits[index].quantite!} F",
                                        style: const TextStyle(
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
                                    controller.lignesProduits.removeAt(index);
                                    controller.update();
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
                    controller: controller.searchController,
                    onChanged: (data) async {
                      await controller.searchData(data);
                    },
                    title: "Produit",
                    hintText: "Rechercher le produit...",
                    suffixIcon: InkWell(
                        onTap: () {
                          print("rechercher");
                        },
                        child: Icon(Icons.search,
                            color: kDarkColor.withOpacity(0.4), size: 26)),
                  ),
                  controller.medicamentsList.isEmpty
                      ? Container()
                      : Container(
                          height:
                              40 * controller.medicamentsList.length.toDouble(),
                          width: Get.width,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  controller.medicamentsList.length,
                                  (index) => TextButton(
                                    onPressed: () {
                                      controller.selectedMedicament(
                                          controller.medicamentsList[index]);
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 35,
                                            width: 35,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kDefaultRadius)),
                                            child: Image.asset(
                                              "assets/images/medecine_three.jfif",
                                              fit: BoxFit.fill,
                                            )),
                                        const SizedBox(
                                            width: kDefaultPadding / 3),
                                        Text(
                                            controller.medicamentsList[index]
                                                .nom!.capitalizeFirst!,
                                            style: const TextStyle(
                                              color: kDarkColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Spacer(),
                                        Text(
                                            '${controller.medicamentsList[index].prix!} F',
                                            style: const TextStyle(
                                              color: kOrangeColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const SizedBox(width: 10)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: kDefaultPadding / 2),
                  controller.selectedMedoc == null
                      ? Container()
                      : CardContainer(
                          header: Row(
                            children: [
                              Text(
                                controller.selectedMedoc!.nom!.capitalizeFirst!,
                                style: const TextStyle(
                                  color: kDarkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Ref: ${controller.selectedMedoc!.id!.toString().padLeft(2, '0')}",
                                style: const TextStyle(
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
                              Row(
                                children: [
                                  Text(
                                    "Quantité",
                                    style: TextStyle(
                                      color: kDarkColor.withOpacity(0.6),
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
                                          if (controller
                                                  .selectedMedoc!.quantite! <=
                                              1) {
                                            return;
                                          }
                                          controller.selectedMedoc!.quantite =
                                              controller.selectedMedoc!
                                                      .quantite! -
                                                  1;
                                          controller.update();
                                        },
                                      ),
                                      const SizedBox(
                                          width: kDefaultPadding / 2),
                                      Text(
                                        controller.selectedMedoc!.quantite!
                                            .toString(),
                                        style: const TextStyle(
                                          color: kTextColor2,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                          width: kDefaultPadding / 2),
                                      CircularButton(
                                        text: '+',
                                        onTap: () {
                                          if (controller
                                                  .selectedMedoc!.stock! ==
                                              controller
                                                  .selectedMedoc!.quantite!) {
                                            controller.showMessage(context,
                                                controller.selectedMedoc!.nom!);
                                            return;
                                          }
                                          controller.selectedMedoc!.quantite =
                                              controller.selectedMedoc!
                                                      .quantite! +
                                                  1;
                                          controller.update();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        const Text(
                                          "P.U HT: ",
                                          style: TextStyle(
                                            color: kDarkColor,
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          "${controller.selectedMedoc!.prix!} F",
                                          style: const TextStyle(
                                            color: kTextColor2,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                      Row(children: [
                                        const Text(
                                          "Total: ",
                                          style: TextStyle(
                                            color: kDarkColor,
                                          ),
                                        ),
                                        Text(
                                          "${controller.selectedMedoc!.prix! * controller.selectedMedoc!.quantite!} F",
                                          style: const TextStyle(
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
                                      controller.selectedMedoc = null;
                                      controller.update();
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
                  const SizedBox(height: kDefaultPadding / 2),
                  /*Row(
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
                  ),*/
                  controller.selectedMedoc == null
                      ? Container()
                      : Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 2),
                          child: Row(
                            children: [
                              const Spacer(),
                              CustomButton(
                                title: "Ajouter",
                                onTap: () {
                                  controller.ajouterLigneProduit();
                                },
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: kDefaultPadding),
                  CustomTextField2(
                    controller: controller.textEditingNote,
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
                      Text(
                        "${controller.montantTotal()} F",
                        style: const TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  controller.factureStatus != LoadingStatus.searching
                      ? InkWell(
                          onTap: () async {
                            await controller.save(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kTextColor2,
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius - 2),
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
                        )
                      : Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Center(
                            child: CircularProgressIndicator(color: kTextColor),
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
