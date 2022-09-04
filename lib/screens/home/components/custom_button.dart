import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class CustomButton extends StatelessWidget {
  final String libelle;
  final Color color;
  final Color backgroundColor;
  final Function()? onTap;
  const CustomButton({
    Key? key,
    required this.libelle,
    required this.color,
    required this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 135,
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: 1.2,
            color: kTextColor2,
          ),
          borderRadius: BorderRadius.circular(kDefaultRadius - 4),
        ),
        child: Center(
          child: Text(
            libelle,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
