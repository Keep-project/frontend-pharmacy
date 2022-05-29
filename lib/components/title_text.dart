import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';



class TitleText extends StatelessWidget {
  final String? title;
  const TitleText({
    Key? key, this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: const TextStyle(
        color: kTextColor2,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}

