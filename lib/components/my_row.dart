
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';

class MyRow extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Function()? onPressed;
  const MyRow({
    Key? key,
    this.title,
    this.value,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Text(
            title!,
            style: TextStyle(
              color: kDarkColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onPressed,
            child: Text(
              value!,
              style: TextStyle(
                color: color ?? kDarkColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}