import 'package:get/get.dart';

import 'package:flutter/material.dart';

class DashbordScreenController extends GetxController {
  int key = 0;

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
}
