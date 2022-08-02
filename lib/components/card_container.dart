
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';


class CardContainer extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  const CardContainer({
    Key? key,
    this.header,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultPadding - 4,
          right: kDefaultPadding - 4,
          top: kDefaultPadding - 4,
          bottom: kDefaultPadding / 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius * 1.2),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 30,
            color: kWhiteColor.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          header!,
          const Divider(
            thickness: 0.8,
          ),
          body!,
        ],
      ),
    );
  }
}