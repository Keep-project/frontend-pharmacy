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

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  
}
