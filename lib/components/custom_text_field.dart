
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';


class CustomTextField extends StatelessWidget {
  final Function(String string)? onChanged;
  final String? hintText;
  final IconData? iconData;
  final Function()? onTap;
  const CustomTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.iconData, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1.5,
          color: kTextColor,
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
      ),
      child: TextField(
        onChanged: (String value) {
          onChanged!(value);
        },
        decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: (){onTap!();},
              child: Icon(iconData!, color: kTextColor)),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
                left: 10, top: 16, bottom: 16, right: 10)),
      ),
    );
  }
}