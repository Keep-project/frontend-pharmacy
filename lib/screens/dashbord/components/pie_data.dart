import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';

class PieData {
  static List<Data> data = [
    Data(name: "Blue", percent: 40, color: Colors.blue),
    Data(name: "Orange", percent: 30, color: Colors.orange),
    Data(name: "Black", percent: 15, color: Colors.black),
    Data(name: "Green", percent: 15, color: Colors.green),
  ];
}



class Data{
  final String name;
  final double percent;
  final Color color;

  Data({ required this.name, required this.percent, required this.color});

}

List<PieChartSectionData> getSections(int touchIndex) => PieData.data.asMap().map<int, PieChartSectionData>((index, data){
  
  final bool isTouched = index == touchIndex;
  final double fontSize = isTouched ? 20 : 16;
  final double radius = isTouched ? 90 : 80;
  final value = PieChartSectionData(
    color: data.color,
    value: data.percent,
    title: "${data.percent}%\n${data.name}",
    radius: radius,
    titleStyle: TextStyle(
      color: kWhiteColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    ),
  );

  return MapEntry(index, value);
}).values.toList();