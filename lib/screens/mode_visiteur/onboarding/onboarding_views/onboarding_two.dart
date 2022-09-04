import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: -140,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/onboarding_one.jpg")),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: kTextColor2,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    kDarkColor.withOpacity(0.6),
                    kDarkColor.withOpacity(0.5),
                    kDarkColor.withOpacity(0.5),
                    kDarkColor.withOpacity(0.4),
                    kDarkColor.withOpacity(0.3),
                    kTextColor2.withOpacity(0.2),
                    kDarkColor.withOpacity(0.1),
                    kTextColor.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: kDefaultPadding*5,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding*2),
              child: Column(
                children: const [
                  Text("Etes-vous  à la recherche d'un médicament ?",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.3,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding*1.5,
                  ),
                  Text("Avez-vous parcouru des kilomètres pour rechercher un médicament sans succès ? Cette plateforme vous permet de trouver le médicament et en même temps la pharmacie où il se trouve. Ce qui vous évite les marches inutiles !",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kWhiteColor,
                      height: 1.5,
                      letterSpacing: 1.3,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
