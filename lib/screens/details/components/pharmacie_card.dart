


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class PharmacyCard extends StatelessWidget {
  final String name;
  final String phone;
  final int stock;
  final String status;
  final double? height;
  final double? bottom;
  const PharmacyCard({
    Key? key, required this.name, required this.phone, required this.stock, required this.status,
    this.height, this.bottom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhiteColor,
      elevation: 2,
      shadowColor: kTextColor.withOpacity(.4),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: bottom ?? kDefaultMargin),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(kDefaultRadius)),
      child: Container(
        height: height ?? 90,
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: [
            const Icon(CupertinoIcons.gift_fill,
                color: kTextColor2, size: 45),
            const SizedBox(width: kDefaultPadding / 1.5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(name,
                  style: const TextStyle(
                    color: kDarkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(phone,
                  style: const TextStyle(
                    color: kDarkColor,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    stock != 0 ? Text(
                      "Stock: $stock",
                      style: const TextStyle(
                        color: kDarkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ): Container(),
                    const Spacer(),
                      Text(status,
                      style: const TextStyle(
                        color: kOrangeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
