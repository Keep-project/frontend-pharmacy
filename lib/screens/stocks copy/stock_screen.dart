

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/stocks/stock.dart';


class StockView extends GetView<StockController> {
  const StockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(),
        ),
      ), 
    );
  }
}