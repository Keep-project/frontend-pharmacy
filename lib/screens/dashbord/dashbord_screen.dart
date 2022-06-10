
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/dashbord/components/pie_data.dart';
import 'package:pharmacy_app/screens/dashbord/dashbord_controller.dart';


class DashbordScreen extends GetView<DashbordScreenController> {
  const DashbordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<DashbordScreenController>(
          builder: (controller){
            return Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: const BoxDecoration(
                // color: kTextColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox( height: kDefaultMargin*2),
                    const TitleText(title: "Statistiques",),
                    const SizedBox( height: kDefaultMargin*10),
                    Container(
                      height: 300,
                      width: Get.width,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 0,
                          centerSpaceRadius: 60,
                          sections: getSections(),
                        ),
                      ),
                    ),
                  ],
                ))
            );
          },
        ),
      ),
    );
  }

  
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      title: const Text("John Doe",
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading:  Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left, color: kWhiteColor, size: 30)),
        ),
      ),
      actions: [
        Container(
          height: 45,
          width: 45,
          margin: const EdgeInsets.only(right: kDefaultMargin * 2),
          decoration: BoxDecoration(
            color: kGreyColor,
            shape: BoxShape.circle,
          ),
          child: const Center(
              child: Icon(CupertinoIcons.person_fill,
                  size: 30, color: kWhiteColor)),
        ),
      ],
    );
  }

}