
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';


class CustomTextField extends StatelessWidget {
  final Function(String string)? onChanged;
  final String? hintText;
  final IconData? iconData;
  final Function()? onTap;
  final bool? obscureText;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.iconData,
    this.onTap,
    this.obscureText, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.9,
          color: kTextColor2.withOpacity(0.8),
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
      ),
      child: TextField(
        // onChanged: (String value) {
        //   onChanged!(value);
        // },
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: onTap,
              child: Icon(iconData!, color: kTextColor2)),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
                left: 10, top: 16, bottom: 16, right: 10)),
      ),
    );
  }
}