import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';



class TitleText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  const TitleText({
    Key? key, this.title,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        color: kTextColor2,
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? 16,
      ),
    );
  }
}

