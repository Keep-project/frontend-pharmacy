import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';


class CategoryItem extends StatelessWidget {
  final String? title;
  final Function() onTap;
  const CategoryItem({
    Key? key,
    this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kDefaultMargin*1.5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5,
                vertical: kDefaultPadding / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultRadius * .8),
              border: Border.all(
                width: 1.2,
                color: kTextColor,
              ),
              color: kWhiteColor.withOpacity(.6),
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
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            )),
      ),
    );
  }
}