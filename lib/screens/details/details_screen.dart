import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/details/components/pharmacie_card.dart';
import 'package:pharmacy_app/screens/details/details.dart';

class DetailScreen extends GetView<DetailScreenController> {
  const DetailScreen({Key? key}) : super(key: key);

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
                              text: "${controller.medicament!.nom!}\n",
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
                    Positioned(
                      left: kDefaultPadding,
                      top: kDefaultPadding,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          child: const Icon(CupertinoIcons.arrow_left,
                              color: kDarkColor, size: 30),
                        ),
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
                                        "Stock: ${controller.medicament!.stock!}",
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
                                          const TitleText(
                                              title:
                                                  "Vous trouverez Doliprane 200mg à:"),
                                          const SizedBox(
                                              height: kDefaultMargin * 1.5),
                                          const PharmacyCard(
                                            name: "Pharmacie de Medong",
                                            phone: "Tel: +237 652 310 829",
                                            stock: 45,
                                            status: "Ouverte",
                                          ),
                                          const PharmacyCard(
                                            name: "Pharmacie de TKC",
                                            phone: "Tel: +237 652 310 829",
                                            stock: 83,
                                            status: "Fermée",
                                          ),
                                          const PharmacyCard(
                                            name: "Pharmacie de Biyem-Assi",
                                            phone: "Tel: +237 652 310 829",
                                            stock: 72,
                                            status: "Ouverte",
                                          ),
                                          const PharmacyCard(
                                            name: "Pharmacie de Nlongkak",
                                            phone: "Tel: +237 652 310 829",
                                            stock: 31,
                                            status: "Ouverte",
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
                                        const MyRow(
                                          title: "Prix de vente",
                                          value: "1700 F",
                                        ),
                                        const MyRow(
                                          title: "Prix de vente min.",
                                          value: "1700 F",
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              title: "Modifier les prix",
                                              onTap: () {},
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
                                        CardContainer(
                                          header: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    "Modifié par: Super Admin",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "01/01/2022",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kDarkColor
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: [
                                              const SizedBox(
                                                  height: kDefaultPadding / 2),
                                              const MyRow(
                                                title: "Base de prix",
                                                value: "HT",
                                              ),
                                              const MyRow(
                                                title:
                                                    "Taux de taxe par défaut",
                                                value: "19.25%",
                                              ),
                                              const MyRow(
                                                title: "Montant HT",
                                                value: "1700 F",
                                              ),
                                              const MyRow(
                                                title: "Montant TTC",
                                                value: "2025 F",
                                              ),
                                              const MyRow(
                                                title: "Prix de vente HT",
                                                value: "1700 F",
                                              ),
                                              const MyRow(
                                                title: "Prix de vente TTC",
                                                value: "2025 F",
                                                color: kOrangeColor,
                                              ),
                                              Container(),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: kDefaultPadding),
                                        CardContainer(
                                          header: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    "Modifié par: Super Admin",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "11/05/2022",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kDarkColor
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: [
                                              const SizedBox(
                                                  height: kDefaultPadding / 2),
                                              const MyRow(
                                                title: "Base de prix",
                                                value: "HT",
                                              ),
                                              const MyRow(
                                                title:
                                                    "Taux de taxe par défaut",
                                                value: "0%",
                                              ),
                                              const MyRow(
                                                title: "Montant HT",
                                                value: "1700 F",
                                              ),
                                              const MyRow(
                                                title: "Montant TTC",
                                                value: "2025 F",
                                              ),
                                              const MyRow(
                                                title: "Prix de vente HT",
                                                value: "1700 F",
                                              ),
                                              const MyRow(
                                                title: "Prix de vente TTC",
                                                value: "2025 F",
                                                color: kOrangeColor,
                                              ),
                                              Container(),
                                            ],
                                          ),
                                        ),
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
                                          value: "1700 F",
                                          onPressed: () {},
                                        ),
                                        const MyRow(
                                          title: "Limite stock pour alerte",
                                          value: "20",
                                        ),
                                        const MyRow(
                                          title: "Stock désiré optimal",
                                          value: "120",
                                        ),
                                        const MyRow(
                                          title: "Stock physique",
                                          value: "45",
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
                                              onPressed: () {},
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
                                              onTap: () {},
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomButton(
                                              title: "Corriger le stock",
                                              onTap: () {},
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Total de pièces",
                                                      style: TextStyle(
                                                        color: kDarkColor.withOpacity(0.7),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text("2",
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
                                                    Text("Montant total à la vente",
                                                      style: TextStyle(
                                                        color: kDarkColor.withOpacity(0.7),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text("97000 F",
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
                                        ),
                                        const SizedBox(height: 16),
                                        CardContainer(
                                          header: Row(
                                            children: const [
                                              Text(
                                                "Entrepôt 01",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "ET001",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: const [
                                              SizedBox(
                                                  height: kDefaultPadding / 2),
                                              MyRow(
                                                title: "Nombre de pièce",
                                                value: "45",
                                                color: kOrangeColor,
                                              ),
                                              MyRow(
                                                title:
                                                    "Prix moyen pondéré (PMP)",
                                                value: "1700 F",
                                              ),
                                              MyRow(
                                                title: "Valorisation à l'achat",
                                                value: "76500 F",
                                              ),
                                              MyRow(
                                                title: "Prix de vente unitaire",
                                                value: "1800 F",
                                              ),
                                              MyRow(
                                                title: "Valeur à la vente",
                                                value: "81000 F",
                                                color: kOrangeColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        CardContainer(
                                          header: Row(
                                            children: const [
                                              Text(
                                                "Entrepôt 02",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "ET002",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: const [
                                              SizedBox(
                                                  height: kDefaultPadding / 2),
                                              MyRow(
                                                title: "Nombre de pièce",
                                                value: "15",
                                                color: kOrangeColor,
                                              ),
                                              MyRow(
                                                title:
                                                    "Prix moyen pondéré (PMP)",
                                                value: "1000 F",
                                              ),
                                              MyRow(
                                                title: "Valorisation à l'achat",
                                                value: "15000 F",
                                              ),
                                              MyRow(
                                                title: "Prix de vente unitaire",
                                                value: "1100 F",
                                              ),
                                              MyRow(
                                                title: "Valeur à la vente",
                                                value: "16500 F",
                                                color: kOrangeColor,
                                              ),
                                            ],
                                          ),
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
                                          value: "Super Admin",
                                          onPressed: () {},
                                        ),
                                        const MyRow(
                                          title: "Date de création",
                                          value: "10/02/2008",
                                        ),
                                        MyRow(
                                          title: "Modifié par",
                                          value: "Super Admin",
                                          onPressed: () {},
                                        ),
                                        const MyRow(
                                          title: "Date dernière modification",
                                          value: "10/04/2015",
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              "Objets réferents: ",
                                              style: TextStyle(
                                                color: kDarkColor.withOpacity(0.9),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Nbre d'objets référents",
                                                      style: TextStyle(
                                                        color: kDarkColor.withOpacity(0.7),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text("2",
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
                                                    Text("Quantité totale",
                                                      style: TextStyle(
                                                        color: kDarkColor.withOpacity(0.7),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text("5",
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
                                        ),
                                        const SizedBox(height: 16),
                                        CardContainer(
                                          header: Row(
                                            children: const [
                                              Text(
                                                "Référence",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "FAC001",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: const [
                                              SizedBox(
                                                  height: kDefaultPadding / 2),
                                              MyRow(
                                                title: "Code utilisateur",
                                                value: "45",
                                                color: kOrangeColor,
                                              ),
                                              MyRow(
                                                title:
                                                    "Date facturation",
                                                value: "10/02/2001",
                                              ),
                                              MyRow(
                                                title: "Quantité",
                                                value: "2",
                                              ),
                                              MyRow(
                                                title: "Montant HT",
                                                value: "1800 F",
                                              ),
                                              MyRow(
                                                title: "Etat facture",
                                                value: "Brouillon",
                                                color: kOrangeColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        CardContainer(
                                          header: Row(
                                            children: const [
                                              Text(
                                                "Référence",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "FAC050",
                                                style: TextStyle(
                                                  color: kDarkColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: Column(
                                            children: const [
                                              SizedBox(
                                                  height: kDefaultPadding / 2),
                                              MyRow(
                                                title: "Code utilisateur",
                                                value: "45",
                                                color: kOrangeColor,
                                              ),
                                              MyRow(
                                                title:
                                                    "Date facturation",
                                                value: "10/02/2001",
                                              ),
                                              MyRow(
                                                title: "Quantité",
                                                value: "3",
                                              ),
                                              MyRow(
                                                title: "Montant HT",
                                                value: "1800 F",
                                              ),
                                              MyRow(
                                                title: "Etat facture",
                                                value: "Payée",
                                                color: kOrangeColor,
                                              ),
                                            ],
                                          ),
                                        ),
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



class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  const CustomButton({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(
            color: kTextColor2,
            borderRadius: BorderRadius.circular(kDefaultRadius / 2),
          ),
          child: Text(
            title!,
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}

class MyRow extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Function()? onPressed;
  const MyRow({
    Key? key,
    this.title,
    this.value,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Text(
            title!,
            style: TextStyle(
              color: kDarkColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onPressed,
            child: Text(
              value!,
              style: TextStyle(
                color: color ?? kDarkColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final int? index;
  final String? title;
  final Function()? onTap;
  final dynamic controller;
  const ActionButton({
    Key? key,
    this.index,
    this.title,
    this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 1.5,
                  vertical: kDefaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultRadius * .8),
                border: Border.all(
                  width: 1.2,
                  color: index == controller!.selectedIndex.value
                      ? kTextColor2
                      : kTextColor,
                ),
                color: index == controller!.selectedIndex.value
                    ? kTextColor2
                    : kWhiteColor.withOpacity(.6),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    color: kTextColor.withOpacity(0.2),
                  ),
                ],
              ),
              child: Text(
                title!,
                style: TextStyle(
                  color: index == controller!.selectedIndex.value
                      ? kWhiteColor
                      : Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              )),
        ));
  }
}
