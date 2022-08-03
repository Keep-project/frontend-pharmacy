import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';

class CustomTextField2 extends StatelessWidget {
  final Function(String string)? onChanged;
  final Widget? suffixIcon;
  final String? title;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLines;
  const CustomTextField2({
    Key? key,
    required this.onChanged,
    this.suffixIcon,
    required this.title,
    required this.hintText,
    this.textInputType,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title!,
        style: TextStyle(
          color: kTextColor2.withOpacity(0.8),
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 5),
      Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            width: 1,
            color: kTextColor2.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
            onChanged: onChanged,
            keyboardType: textInputType ?? TextInputType.text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              isDense: true,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 14),
              suffixIcon: suffixIcon ??
                  Icon(Icons.add, color: Colors.grey.withOpacity(0)),
            )),
      ),
    ]);
  }
}
