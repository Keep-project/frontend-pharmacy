// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/home/components/medicament_card.dart';
import 'package:pharmacy_app/screens/home/components/search_custom_button.dart';
import 'package:pharmacy_app/screens/medicaments/medicaments.dart';

class MedicamentScreen extends GetView<MedicamentscreenController> {
  const MedicamentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<MedicamentscreenController>(builder: (controller) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  SearchBarAndButton(context: context, controller: controller, onTap: () async {controller.filterMedicamentsList();}),
                  const SizedBox(height: kDefaultMargin * 2.2),
                  const TitleText(
                    title: "Liste des médicaments",
                  ),
                  const SizedBox(height: kDefaultMargin * 2.2),
                  controller.infinityStatus == LoadingStatus.searching &&
                          controller.medicamentsList.isEmpty
                      ? const Expanded(
                          child: Center(
                            child:
                                CircularProgressIndicator(color: kOrangeColor),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Wrap(
                              runSpacing: kDefaultPadding - 10,
                              spacing: kDefaultPadding + 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...List.generate(
                                    controller.medicamentsList.length,
                                    (index) => MedicamentCard(medicament: controller.medicamentsList[index])),

                                controller.infinityStatus ==
                                        LoadingStatus.searching
                                    ? Container(
                                        padding: const EdgeInsets.all(0),
                                        height: 220,
                                        //width: Get.width / 2 - 32,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                              color: kOrangeColor),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                  controller.medicamentsList.isEmpty &&
                          controller.infinityStatus == LoadingStatus.completed
                      ? Container(
                          padding: const EdgeInsets.all(0),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Ooops !!!\nAucun médicament trouvé",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kGreyColor.withOpacity(0.7),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ));
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: Center(
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left,
                  color: kWhiteColor, size: 30)),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.DASHBORD);
          },
          child: Container(
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
        ),
      ],
    );
  }
}
