import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';


class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.RENDEZVOUSDETAILS);
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: kDefaultMargin * 2),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(kDefaultRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 30,
              color: kTextColor2.withOpacity(0.02),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
              child: Center(
                child: SvgPicture.asset("assets/images/icon-person.svg"),
              ),
            ),
            const SizedBox(width: kDefaultMargin*3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text("Dr Larissa Meleuk",
                  style: TextStyle(
                    color: kDarkColor.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Text("06 ans d'expérience",
                  style: TextStyle(
                    color: kDarkColor.withOpacity(0.3),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(flex: 2,),
              ],
            ),
          ]
        ),
      ),
    );
  }
}