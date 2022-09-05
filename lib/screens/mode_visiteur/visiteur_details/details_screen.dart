import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/custom_button.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/pharmacie_card.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_visiteur/visiteur_details/details.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailVisteurScreen extends GetView<DetailScreenController> {
  const DetailVisteurScreen({Key? key}) : super(key: key);

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
                                          fontSize: 11,
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
                              const SizedBox(height: kDefaultMargin),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: kDefaultMargin * 2),
                                    const TitleText(title: "Description"),
                                    const SizedBox(height: kDefaultMargin),
                                    Text(
                                      controller.medicament!.description!,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: kDarkColor.withOpacity(0.4),
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultMargin / 2),
                                    const Divider(
                                      thickness: 0.9,
                                    ),
                                    const SizedBox(height: kDefaultMargin),
                                    const TitleText(title: "Posologie"),
                                    Text(
                                      controller.medicament!.posologie!,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: kDarkColor.withOpacity(0.4),
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultMargin * 3),
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
                                            Get.toNamed(AppRoutes.MAPVIEW);
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          kDefaultPadding / 1.5,
                                                      vertical:
                                                          kDefaultPadding / 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kDefaultRadius / 1.3),
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
                                    const SizedBox(height: kDefaultMargin * 3),
                                    TitleText(
                                        title:
                                            "Vous trouverez ${controller.medicament!.nom!.toString()} à:"),
                                    const SizedBox(
                                        height: kDefaultMargin * 1.5),
                                    ...List.generate(
                                      controller.medicament!.pharmacies!.length,
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
                                                          (int.parse(controller
                                                              .medicament!
                                                              .pharmacies![
                                                                  index]
                                                              .ouverture!
                                                              .split(
                                                                  ":")[0]))) &&
                                                      controller
                                                          .medicament!
                                                          .pharmacies![index]
                                                          .ouverture!
                                                          .endsWith("AM")) &&
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


