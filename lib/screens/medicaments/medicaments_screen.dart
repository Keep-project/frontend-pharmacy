// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/components/medicament_card.dart';
import 'package:pharmacy_app/screens/home/components/search_custom_button.dart';
import 'package:pharmacy_app/screens/medicaments/medicaments.dart';

class MedicamentScreen extends GetView<MedicamentscreenController> {
  const MedicamentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: buildAppBar(controller, context),
        drawer: const AppNavigationDrawer(),
        body: GetBuilder<MedicamentscreenController>(builder: (controller) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  SearchBarAndButton(
                      context: context,
                      controller: controller,
                      onChanged: (data)async{ await controller.searchData(data); },
                      onTap: () async {
                        unfocus();
                        if (controller.searchController.text.isEmpty) {
                          return;
                        }
                        controller.filterMedicamentsList();
                      }),
                  const SizedBox(height: kDefaultMargin * 2.2),
                  TitleText(
                    title: "Liste des médicaments (${controller.medicamentsList.length})",
                  ),
                  const SizedBox(height: kDefaultMargin * 2.2),
                  controller.infinityStatus == LoadingStatus.searching &&
                          controller.medicamentsList.isEmpty
                      ? const Expanded(
                          child: Center(
                            child:
                                CircularProgressIndicator(color: kTextColor),
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
                                    (index) => MedicamentCard(
                                        medicament:
                                            controller.medicamentsList[index])),
                                controller.infinityStatus ==
                                        LoadingStatus.searching
                                    ? Container(
                                        padding: const EdgeInsets.all(0),
                                        height: 220,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                              color: kTextColor),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                  controller.medicamentsList.isEmpty &&
                          controller.infinityStatus == LoadingStatus.completed
                      ? Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(),
                            width: double.infinity,
                            child: Text(
                              "Ooops !!!\nAucun médicament trouvé",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kGreyColor.withOpacity(0.7),
                                fontSize: 18,
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

  AppBar buildAppBar(MedicamentscreenController controller, BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
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
        GestureDetector(
          onTap: () {
            unfocus();
            controller.openDrawer();
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
                child: Icon(Icons.menu,
                    size: 30, color: kWhiteColor)),
          ),
        ),
      ],
    );
  }
}
