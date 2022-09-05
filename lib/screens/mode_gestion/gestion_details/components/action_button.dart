

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

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