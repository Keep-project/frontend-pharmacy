import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';

class ActionsDialog extends StatelessWidget {
  const ActionsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius * 1.3)),
      alignment: Alignment.center,
      child: Container(
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Actions",
              style: TextStyle(
                color: kTextColor2,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              thickness: 1.7,
            ),
            const SizedBox(
              height: kDefaultMargin,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.PHARMACIEFORM);
              },
              child: Row(
                children: [
                  const Text(
                    "Ajouter une pharmacie",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: kTextColor2,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: kWhiteColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultMargin * 1.5),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.MEDICAMENTSFORM);
              },
              child: Row(
                children: [
                  const Text(
                    "Ajouter un médicament",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: kTextColor2,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: kWhiteColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultMargin),
          ],
        ),
      ),
    );
  }
}