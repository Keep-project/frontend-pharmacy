import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/start/start.dart';

class StartScreen extends GetView<StartScreenController> {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<StartScreenController>(
          builder: (controller) => Scaffold(
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const BoxDecoration(),
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
                                      Image.asset("assets/images/image1.png"),
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding * 2),
                              Text(
                                "Bien spécifier votre besoin rend votre naviagtion fluide et facile",
                                style: TextStyle(
                                  color: kTextColor2.withOpacity(.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: kDefaultPadding * 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.MAPVIEW);
                              },
                              child: Container(
                                  height: 220,
                                  width: Get.width / 2 - 30,
                                  decoration: BoxDecoration(
                                    color: kTextColor.withOpacity(.08),
                                    borderRadius:
                                        BorderRadius.circular(kDefaultPadding),
                                  ),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      children: [
                                        const Spacer(flex: 2),
                                        Text(
                                          "Rechercher une Pharmacie",
                                          style: TextStyle(
                                            color: kTextColor.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(children: [
                                          const Spacer(),
                                          Icon(CupertinoIcons.arrow_right,
                                              size: 26,
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
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.HOME);
                              },
                              child: Container(
                                  height: 220,
                                  width: Get.width / 2 - 30,
                                  decoration: BoxDecoration(
                                    color: kTextColor.withOpacity(.08),
                                    borderRadius:
                                        BorderRadius.circular(kDefaultPadding),
                                  ),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      children: [
                                        const Spacer(flex: 2),
                                        Text(
                                          "Rechercher des médicaments",
                                          style: TextStyle(
                                            color: kTextColor.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(children: [
                                          const Spacer(),
                                          Icon(CupertinoIcons.arrow_right,
                                              size: 26,
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
                          ],
                        ),
                      ),
                      const SizedBox( height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Container(
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kTextColor.withOpacity(.08),
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              decoration: const BoxDecoration(),
                              child: Stack(
                                children: [
                                  Image.asset("assets/images/amico-care.png"),
                                  const Positioned(
                                    top: 10,
                                    right: 0,
                                    child: Text("Préconsultation", 
                                      style: TextStyle(
                                        color: kTextColor2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ),
                                  Positioned(
                                    top: 40,
                                    right: 0,
                                    child: Container(
                                      width: 150,
                                      decoration: const BoxDecoration(),
                                      child: const Text(
                                        "Faire des préconsultations en ligne et vous rendrez chez le médecin seulement lorsque celà est nécessaire",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: kTextColor2,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 35,
                                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                      decoration: BoxDecoration(
                                        color: kTextColor.withOpacity(.08),
                                        borderRadius: BorderRadius.circular(kDefaultRadius*2),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset( 0, 10),
                                            blurRadius: 30,
                                            color: kTextColor.withOpacity(0.15)
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text("Consultez-vous en ligne", 
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        )
                                    ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
