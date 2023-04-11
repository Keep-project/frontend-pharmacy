
// ignore_for_file: avoid_print

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/dashbord/components/pie_data.dart';
import 'package:pharmacy_app/screens/dashbord/dashbord_controller.dart';
import 'package:pharmacy_app/components/medicament_card.dart';


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
                    const TitleText(title: "Bienvenue sur votre Dashbord",),
                    
                    // Text("Le dernier jour du mois est ${controller.lastDayOfMonth.month}/${controller.lastDayOfMonth.day}"),
                    const SizedBox( height: kDefaultMargin*2),
                    const TitleText(title: "Statistiques",),
                    const SizedBox( height: kDefaultMargin),
                    Center(
                      child: Container(
                        height: 300,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          // color: Colors.black,
                        ),
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (touchEvent, pieTouchResponse){
                                if (pieTouchResponse != null && ( pieTouchResponse.touchedSection is FlLongPressEnd || pieTouchResponse.touchedSection is FlPanEndEvent)){
                                  controller.touchIndex = -1;
                                }
                                else{
                                  try {
                                    controller.touchIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
                                    controller.update();
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              }
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 50,
                            sections: getSections(controller.touchIndex),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox( height: kDefaultMargin*4),
                    const TitleText(title: "Médicaments récents(06)",),
                    const SizedBox( height: kDefaultMargin*2),
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(controller.medicamentsList.length, (index) => Container(
                          margin: const EdgeInsets.only(right: kDefaultMargin*2),
                          child: MedicamentCard(medicament: controller.medicamentsList[index], isInternetConnection: false,),)),
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