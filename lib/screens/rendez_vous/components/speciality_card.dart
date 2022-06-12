import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';



class SpecialityCard extends StatelessWidget {
  final String assetName;
  final String title;
  final int number;
  const SpecialityCard({
    Key? key,
    required this.assetName,
    required this.title,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 117,
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      margin: const EdgeInsets.only(right: kDefaultMargin * 1.6),
      decoration: BoxDecoration(
        color: kTextColor2.withOpacity(0.9),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            width: 35,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: SvgPicture.asset(
              assetName,
              fit: BoxFit.fill,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 4),
              decoration: BoxDecoration(
                  color: kTextColor2,
                  borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
              child: Text(
                "$number Docteurs",
                style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }
}