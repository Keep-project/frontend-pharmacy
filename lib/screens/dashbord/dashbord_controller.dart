// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DashbordScreenController extends GetxController {
  int key = 0;
  int touchIndex = -1;

  Map<String, dynamic> dataMap = {
    'Electricity': 5,
    'Water': 2,
    'Food': 2,
    'Gas': 3,
  };

  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  DateTime now = DateTime.now();

  @override
  void onInit() {
    lastDayOfMonth();
    super.onInit();
  }

  int lastDayOfMonth() {
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    DateTime currentDate =  DateTime.parse("${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} 00:00:00.0");
    
    print("Le dernier jour du mois sera le : ${lastDayOfMonth.day}");

    final dateName = DateFormat('EEEE, d MMM yyyy').format(currentDate);
    print("date name $dateName");
    return lastDayOfMonth.day;
  }
}
