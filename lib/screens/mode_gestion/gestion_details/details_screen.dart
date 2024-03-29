import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/components/pharmacie_card.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/components/action_button.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/components/change_price.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/components/corriger_stock.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/components/transfert_stock.dart';
import 'package:pharmacy_app/screens/mode_gestion/gestion_details/details.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailGestionScreen extends GetView<DetailScreenController> {
  const DetailGestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<DetailScreenController>(builder: (controller) {
          return controller.medicamentStatus == LoadingStatus.searching
              ? Container(
                  decoration: const BoxDecoration(),
                  child: const Center(
                      child: CircularProgressIndicator(color: kTextColor)),
                )
              : Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      height: Get.height,
                      width: Get.width,
                    ),
                    Hero(
                      tag: Get.arguments,
                      child: Container(
                        height: 250,
                        width: Get.width,
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                            right: kDefaultPadding,
                            top: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(controller.medicament!.photo!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: kDefaultPadding,
                      top: 170,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${controller.medicament!.nom!.capitalizeFirst}\n",
                              style: const TextStyle(
                                color: kDarkColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Fabriquant: ${controller.medicament!.marque!.toString().capitalizeFirst}",
                              style: const TextStyle(
                                color: kOrangeColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: kDefaultPadding,
                          right: kDefaultPadding,
                          top: kDefaultPadding / 1.8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: const Icon(CupertinoIcons.arrow_left,
                                  color: kDarkColor, size: 30),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.offAndToNamed(AppRoutes.MEDICAMENTSFORM,
                                  arguments: controller.medicament!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kTextColor2.withOpacity(0.2)),
                              child: const Center(
                                  child: Icon(Icons.edit, size: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F9FA),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(kDefaultRadius * 3),
                            topRight: Radius.circular(kDefaultRadius * 3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, -10),
                              blurRadius: 5,
                              color: kDarkColor.withOpacity(0.022),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: const [
                                        Icon(Icons.room,
                                            color: kOrangeColor, size: 20),
                                        Text(
                                          "Yaoundé, Cameroun",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kDarkColor,
                                          ),
                                        ),
                                      ]),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Prix: ${controller.medicament!.prix!} Fcfa",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: kDarkColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        controller.medicament!.masse!,
                                        style: const TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                      Text(
                                        "Exp: ${controller.medicament!.dateToString()}",
                                        style: const TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                      Text(
                                        "Stock: ${controller.medicament!.stock!.toString()}",
                                        style: const TextStyle(
                                          color: kDarkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: kDefaultMargin * 3),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ActionButton(
                                      onTap: () {
                                        controller.changeSelectedIndex(0);
                                      },
                                      index: 0,
                                      title: "Médicament",
                                      controller: controller,
                                    ),
                                    const SizedBox(width: kDefaultMargin * 1.5),
                                    ActionButton(
                                      onTap: () {
                                        controller.changeSelectedIndex(1);
                                      },
                                      index: 1,
                                      title: "Prix de vente",
                                      controller: controller,
                                    ),
                                    const SizedBox(width: kDefaultMargin * 1.5),
                                    ActionButton(
                                      onTap: () {
                                        controller.changeSelectedIndex(2);
                                      },
                                      index: 2,
                                      title: "Stock",
                                      controller: controller,
                                    ),
                                    const SizedBox(width: kDefaultMargin * 1.5),
                                    ActionButton(
                                      onTap: () {
                                        controller.changeSelectedIndex(3);
                                      },
                                      index: 3,
                                      title: "Statistiques",
                                      controller: controller,
                                    ),
                                    const SizedBox(width: kDefaultMargin * 1.5),
                                    ActionButton(
                                      onTap: () {
                                        controller.changeSelectedIndex(4);
                                      },
                                      index: 4,
                                      title: "Evènement",
                                      controller: controller,
                                    ),
                                  ],
                                ),
                              ),
                              controller.selectedIndex.value == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          const SizedBox(
                                              height: kDefaultMargin * 2),
                                          const TitleText(title: "Description"),
                                          const SizedBox(
                                              height: kDefaultMargin),
                                          Text(
                                            controller.medicament!.description!,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.4),
                                              fontSize: 16,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(
                                              height: kDefaultMargin / 2),
                                          const Divider(
                                            thickness: 1.5,
                                          ),
                                          const SizedBox(
                                              height: kDefaultMargin),
                                          const TitleText(title: "Posologie"),
                                          Text(
                                            controller.medicament!.posologie!,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.4),
                                              fontSize: 16,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(
                                              height: kDefaultMargin * 3),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const TitleText(
                                                      title: " Localisation"),
                                                  Row(children: const [
                                                    Icon(Icons.room,
                                                        color: kOrangeColor,
                                                        size: 20),
                                                    Text(
                                                      "Yaoundé, Cameroun",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: kOrangeColor,
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.MAPVIEW);
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal:
                                                            kDefaultPadding /
                                                                1.5,
                                                        vertical:
                                                            kDefaultPadding /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kDefaultRadius /
                                                                  1.3),
                                                      color: kTextColor2,
                                                    ),
                                                    child: const Text(
                                                      "Voir sur la map",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kWhiteColor,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kDefaultMargin * 3),
                                          TitleText(
                                              title:
                                                  "Vous trouverez ${controller.medicament!.nom!.toString()} à:"),
                                          const SizedBox(
                                              height: kDefaultMargin * 1.5),
                                          ...List.generate(
                                            controller
                                                .medicament!.pharmacies!.length,
                                            (index) => InkWell(
                                              onTap: () async {
                                                launchUrl(Uri.parse(
                                                    "tel://${controller.medicament!.pharmacies![index].phone!}"));
                                              },
                                              child: PharmacyCard(
                                                name: controller.medicament!
                                                    .pharmacies![index].nom!
                                                    .toString()
                                                    .capitalize!,
                                                phone:
                                                    "Tel: ${controller.medicament!.pharmacies![index].phone!.toString()}",
                                                stock: controller.medicament!
                                                    .pharmacies![index].stock!,
                                                status: (((DateTime.now().hour >=
                                                                (int.parse(controller.medicament!.pharmacies![index].ouverture!.split(":")[
                                                                    0]))) &&
                                                            controller
                                                                .medicament!
                                                                .pharmacies![
                                                                    index]
                                                                .ouverture!
                                                                .endsWith(
                                                                    "AM")) &&
                                                        ((DateTime.now().hour <=
                                                                (int.parse(controller.medicament!.pharmacies![index].fermeture!.split(":")[0])) +
                                                                    12) &&
                                                            controller
                                                                .medicament!
                                                                .pharmacies![index]
                                                                .fermeture!
                                                                .endsWith("PM")))
                                                    ? "Ouverte"
                                                    : 'Fermée',
                                              ),
                                            ),
                                          ),
                                        ])
                                  : Container(),
                              controller.selectedIndex.value == 1
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height: kDefaultMargin * 3),
                                        MyRow(
                                          title: "Taux de taxe par défaut",
                                          value: "19.25%",
                                          onPressed: () {},
                                        ),
                                        MyRow(
                                          title: "Prix de vente",
                                          value:
                                              "${controller.medicament!.prix} F",
                                        ),
                                        MyRow(
                                          title: "Prix de vente min.",
                                          value:
                                              "${controller.medicament!.prix} F",
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              title: "Modifier les prix",
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    /*topRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),*/
                                                                    )),
                                                    builder: (context) {
                                                      return ChangePrice(
                                                          controller:
                                                              controller,
                                                          context: context);
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
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
                                                title:
                                                    "Historique des prix précédents"),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: kDefaultPadding - 4),
                                        ...List.generate(
                                          controller
                                              .medicament!.historiques!.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: kDefaultPadding / 1.5),
                                            child: CardContainer(
                                              header: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Pratiqué à partir du",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: kDarkColor
                                                              .withOpacity(0.7),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Modifié par: ${controller.medicament!.createur!.username.toString().capitalize}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    controller.medicament!
                                                        .historiques![index]
                                                        .createdToString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: kDarkColor
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              body: Column(
                                                children: [
                                                  const SizedBox(
                                                      height:
                                                          kDefaultPadding / 2),
                                                  MyRow(
                                                    title: "Base de prix",
                                                    value: controller
                                                        .medicament!
                                                        .historiques![index]
                                                        .basePrix,
                                                  ),
                                                  MyRow(
                                                    title:
                                                        "Taux de taxe par défaut",
                                                    value:
                                                        "${controller.medicament!.historiques![index].tva}%",
                                                  ),
                                                  MyRow(
                                                    title: "Montant HT",
                                                    value:
                                                        "${controller.medicament!.historiques![index].prixVente} F",
                                                  ),
                                                  MyRow(
                                                    title: "Montant TTC",
                                                    value:
                                                        "${controller.medicament!.historiques![index].prixVente! + (controller.medicament!.historiques![index].prixVente! * controller.medicament!.historiques![index].tva!) / 100} F",
                                                  ),
                                                  MyRow(
                                                    title: "Prix de vente HT",
                                                    value:
                                                        "${controller.medicament!.historiques![index].prixVente} F",
                                                  ),
                                                  MyRow(
                                                    title: "Prix de vente TTC",
                                                    value:
                                                        "${controller.medicament!.historiques![index].prixVente! + (controller.medicament!.historiques![index].prixVente! * controller.medicament!.historiques![index].tva!) / 100} F",
                                                    color: kOrangeColor,
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: kDefaultPadding / 2),
                                      ],
                                    )
                                  : Container(),
                              controller.selectedIndex.value == 2
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                            height: kDefaultMargin * 3),
                                        MyRow(
                                          title: "Prix moyen pondéré (PMP)",
                                          value:
                                              "${controller.medicament!.prix} F",
                                          onPressed: () {},
                                        ),
                                        MyRow(
                                          title: "Limite stock pour alerte",
                                          value:
                                              "${controller.medicament!.stockAlert}",
                                        ),
                                        MyRow(
                                          title: "Stock désiré optimal",
                                          value:
                                              "${controller.medicament!.stockOptimal}",
                                        ),
                                        MyRow(
                                          title: "Stock physique",
                                          value:
                                              "${controller.medicament!.stock}",
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dernier mouvement",
                                                  style: TextStyle(
                                                    color: kDarkColor
                                                        .withOpacity(.8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  "Le: 11/05/2022",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: kDarkColor
                                                        .withOpacity(0.7),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    AppRoutes.MOUVEMENT_PRODUIT,
                                                    arguments: {
                                                      'id': controller
                                                          .medicament!.id!
                                                          .toString(),
                                                      'productName': controller
                                                          .medicament!.nom!
                                                    });
                                              },
                                              child: const Text(
                                                "Liste des mouvements",
                                                style: TextStyle(
                                                  color: kTextColor2,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                            height: kDefaultPadding / 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              title: "Transférer le stock",
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),
                                                    )),
                                                    builder: (context) {
                                                      return TransfertStock(
                                                          controller:
                                                              controller);
                                                    });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomButton(
                                              title: "Corriger le stock",
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    /*topRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),*/
                                                                    )),
                                                    builder: (context) {
                                                      return CorrigerStock(
                                                          controller:
                                                              controller);
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: kDefaultPadding * 1.7),
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 30,
                                              decoration: const BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  "assets/icons/warehouse.svg",
                                                  fit: BoxFit.fill),
                                            ),
                                            const SizedBox(width: 5),
                                            const TitleText(
                                                title: "Liste des entrepôts"),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color:
                                                kTextColor.withOpacity(0.106),
                                            borderRadius: BorderRadius.circular(
                                                kDefaultRadius),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Total de pièces",
                                                      style: TextStyle(
                                                        color: kDarkColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .medicament!.stock
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: kOrangeColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      "Montant total à la vente",
                                                      style: TextStyle(
                                                        color: kDarkColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${controller.medicament!.stock! * controller.medicament!.prix!} F",
                                                      style: TextStyle(
                                                        color: kOrangeColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ...List.generate(
                                          controller
                                              .medicament!.entrepots!.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: kDefaultPadding / 1.5),
                                            child: CardContainer(
                                              header: Row(
                                                children: [
                                                  Text(
                                                    controller.medicament!
                                                        .entrepots![index].nom!,
                                                    style: const TextStyle(
                                                      color: kDarkColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "ENT${controller.medicament!.entrepots![index].id!.toString().padLeft(2, '0')}",
                                                    style: const TextStyle(
                                                      color: kDarkColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              body: Column(
                                                children: [
                                                  const SizedBox(
                                                      height:
                                                          kDefaultPadding / 2),
                                                  MyRow(
                                                    title: "Nombre de pièce",
                                                    value: controller
                                                        .medicament!.stock!
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    color: kOrangeColor,
                                                  ),
                                                  MyRow(
                                                    title:
                                                        "Prix moyen pondéré (PMP)",
                                                    value:
                                                        "${controller.medicament!.prix!} F",
                                                  ),
                                                  MyRow(
                                                    title:
                                                        "Valorisation à l'achat",
                                                    value:
                                                        "${controller.medicament!.prix! * controller.medicament!.stock!} F",
                                                  ),
                                                  MyRow(
                                                    title:
                                                        "Prix de vente unitaire",
                                                    value:
                                                        "${controller.medicament!.prix!} F",
                                                  ),
                                                  MyRow(
                                                    title: "Valeur à la vente",
                                                    value:
                                                        "${controller.medicament!.prix! * controller.medicament!.stock!} F",
                                                    color: kOrangeColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )
                                  : Container(),
                              controller.selectedIndex.value == 3
                                  ? Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      Wrap(
                                          spacing: kDefaultPadding,
                                          runSpacing: kDefaultPadding,
                                          children: [
                                            GestureDetector(
                                                onTap: () async {},
                                                child: Container(
                                                    height: 200,
                                                    width: Get.width /2-30,
                                                    decoration: BoxDecoration(
                                                      color: kTextColor2
                                                          .withOpacity(.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kDefaultPadding),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              kDefaultPadding /
                                                                  2),
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          Container(
                                                            height: 60,
                                                            width: 50,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Image.asset(
                                                              "assets/images/medecine_three.jfif",
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            "Quantité totale",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                              color: kDarkColor
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
                                                              fontStyle: FontStyle
                                                                  .italic,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kDefaultPadding /
                                                                      2),
                                                          Text(controller.medicament!.stock!.toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                                style: const TextStyle(
                                                              color: kDarkColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                            
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            "Stock d'alert",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                              color: kDarkColor
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
                                                              fontStyle: FontStyle
                                                                  .italic,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kDefaultPadding /
                                                                      2),
                                                          Text(controller.medicament!.stockAlert!.toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                                style: TextStyle(
                                                              color: kOrangeColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                            
                                                          ),
                                                          const Spacer(),
                                                          
                                                          const Spacer(
                                                            flex: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            GestureDetector(
                                                onTap: () async {},
                                                child: Container(
                                                    height: 200,
                                                    width: Get.width /2-30,
                                                    decoration: BoxDecoration(
                                                      color: kTextColor2
                                                          .withOpacity(.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kDefaultPadding),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              kDefaultPadding /
                                                                  2),
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          Container(
                                                            height: 60,
                                                            width: 50,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Image.asset(
                                                              "assets/images/medecine_three.jfif",
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            "Quantité totale",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                              color: kDarkColor
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
                                                              fontStyle: FontStyle
                                                                  .italic,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kDefaultPadding /
                                                                      2),
                                                          Text(controller.medicament!.stock!.toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                                style: const TextStyle(
                                                              color: kDarkColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                            
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            "Stock d'alert",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                              color: kDarkColor
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
                                                              fontStyle: FontStyle
                                                                  .italic,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                                  kDefaultPadding /
                                                                      2),
                                                          Text(controller.medicament!.stockAlert!.toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                                style: TextStyle(
                                                              color: kOrangeColor
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                          const Spacer(
                                                            flex: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                    ],
                                  )
                                  : Container(),
                              controller.selectedIndex.value == 4
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                            height: kDefaultMargin * 3),
                                        MyRow(
                                          title: "Crée par",
                                          value: controller
                                              .medicament!.createur!.username
                                              .toString()
                                              .capitalize,
                                          onPressed: () {},
                                        ),
                                        MyRow(
                                          title: "Date de création",
                                          value: controller.medicament!
                                              .createdToString(),
                                        ),
                                        MyRow(
                                          title: "Modifié par",
                                          value: controller
                                              .medicament!.createur!.username
                                              .toString()
                                              .capitalize,
                                          onPressed: () {},
                                        ),
                                        MyRow(
                                          title: "Date dernière modification",
                                          value: controller.medicament!
                                              .updatedToString(),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              "Objets réferents: ",
                                              style: TextStyle(
                                                color:
                                                    kDarkColor.withOpacity(0.9),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              "Factures clients",
                                              style: TextStyle(
                                                color: kTextColor2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                            height: kDefaultPadding / 2),
                                        const SizedBox(height: 16),
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color:
                                                kTextColor.withOpacity(0.106),
                                            borderRadius: BorderRadius.circular(
                                                kDefaultRadius),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Nbre d'objets référents",
                                                      style: TextStyle(
                                                        color: kDarkColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller.factures.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: kOrangeColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      "Quantité totale",
                                                      style: TextStyle(
                                                        color: kDarkColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .quantiteTotalFacture
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: kOrangeColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ...List.generate(
                                          controller.factures.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: kDefaultPadding / 1.5),
                                            child: CardContainer(
                                              header: Row(
                                                children: [
                                                  const Text(
                                                    "Référence",
                                                    style: TextStyle(
                                                      color: kDarkColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "FAC${controller.factures[index].id!.toString().padLeft(2, '0')}",
                                                    style: const TextStyle(
                                                      color: kDarkColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              body: Column(
                                                children: [
                                                  const SizedBox(
                                                      height:
                                                          kDefaultPadding / 2),
                                                  MyRow(
                                                    title: "Code utilisateur",
                                                    value: controller
                                                        .factures[index]
                                                        .utilisateur!
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    color: kOrangeColor,
                                                  ),
                                                  MyRow(
                                                    title: "Date facturation",
                                                    value: controller
                                                        .factures[index]
                                                        .createdToString(),
                                                  ),
                                                  MyRow(
                                                    title: "Quantité",
                                                    value: controller
                                                        .factures[index]
                                                        .quantiteTotal
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                  ),
                                                  MyRow(
                                                    title: "Montant HT",
                                                    value:
                                                        "${controller.factures[index].montantTotal!} F",
                                                  ),
                                                  const MyRow(
                                                    title: "Etat facture",
                                                    value: "Payée",
                                                    color: kOrangeColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
