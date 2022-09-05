

import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class CustomIconButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;
  const CustomIconButton({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: kTextColor2.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(kDefaultRadius - 2),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: kDarkColor.withOpacity(0.5),
                ),
              ),
              const Spacer(),
              Icon(iconData, color: kDarkColor.withOpacity(0.3), size: 26),
            ],
          )),
    );
  }
}
