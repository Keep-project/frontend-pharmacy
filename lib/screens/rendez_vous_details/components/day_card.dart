import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/rendez_vous_details.dart';

class DayCard extends StatelessWidget {
  final int index;
  final RendezVousScreenControllerDetails controller;
  const DayCard({
    Key? key, required this.index, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = controller.selectedDayIndex == index ? kWhiteColor : kDarkColor;
    return GestureDetector(
      onTap: (){
        controller.changeSelectedDay(index);
      },
      child: Container(
        width: 54,
        height: 64,
        margin: const EdgeInsets.only(right: kDefaultMargin),
        decoration: BoxDecoration(
          color: controller.selectedDayIndex == index ? kTextColor2.withOpacity(0.9) : kTextColor2.withOpacity(0.08),
          borderRadius: BorderRadius.circular(kDefaultRadius - 3),
        ),
        child: Column(
          children: [
          const Spacer(),
          Text(controller.dayList[index]["dateName"],
            style: TextStyle(
              color: color,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(controller.dayList[index]["day"].toString().padLeft(2, '0'),
            style: TextStyle(
              color: color,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(controller.dayList[index]["month"].toString(),
            style: TextStyle(
              color: color,
              fontSize: 10,
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}

