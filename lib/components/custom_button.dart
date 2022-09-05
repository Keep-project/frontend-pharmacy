

import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

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