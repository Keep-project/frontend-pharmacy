import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({Key? key}) : super(key: key);

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
            left: -240,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/onboarding_three.jpg")),
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
            bottom: kDefaultPadding*3,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding*2),
              child: Column(
                children: const [
                  Text("A propos",
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
                  Text("Cette application vous offre un espace conviviale pour faciliter la recherche d'un médicament, d'un type de pharmacie (pharmacie de garde, …) à proximité de chez vous, vous donnes une idée sur le coût de chaque produit, vous indique où trouver votre médicament au moment où vous avez besoin et plus encore vous permet de créer un carnet de suivit en ligne.",
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
