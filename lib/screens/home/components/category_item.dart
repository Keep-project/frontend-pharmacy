import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class CategoryItem extends StatelessWidget {
  final String? title;
  final Function() onTap;
  final int? index;
  final dynamic controller;
  const CategoryItem(
      {Key? key, this.title, required this.onTap, this.index, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(right: kDefaultMargin * 1.5),
          child: InkWell(
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 1.5,
                    vertical: kDefaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultRadius * .8),
                  border: Border.all(
                    width: 1.2,
                    color: index == controller!.selectedCategorieIndex.value
                        ? kTextColor2
                        : kTextColor,
                  ),
                  color: index == controller!.selectedCategorieIndex.value
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
                    color: index == controller!.selectedCategorieIndex.value
                        ? kWhiteColor
                        : Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ));
  }
}
