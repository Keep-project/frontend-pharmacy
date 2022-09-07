// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/medicament_card.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/category_item.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/custom_action_dialog.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/search_custom_button.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/home.dart';


class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

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
      child: GetBuilder<HomeScreenController>(builder: (controller) {
        return Scaffold(
          key: controller.homeScaffoldKey,
          appBar: buildAppBar(controller),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const ActionsDialog());
              },
              backgroundColor: kTextColor2,
              child: const Icon(Icons.add, color: kWhiteColor, size: 36)),
          drawer: AppNavigationDrawer(children: controller.drawerItems,),
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kDefaultMargin * 2),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                    text: "Bienvenu sur ",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "Pocket Pharma",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ])),
                const SizedBox(height: kDefaultPadding - 4),
                SearchBarAndButton(
                  context: context,
                  controller: controller,
                  onChanged: (data)async{ await controller.searchData(data); },
                  onTap: () async {
                    unfocus();
                  }
                ),
                const SizedBox(height: kDefaultMargin * 2.2),
                const TitleText(title: "Catégories"),
                const SizedBox(height: kDefaultMargin * 1.6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ...List.generate(
                      controller.categories.length,
                      (index) => 
                        CategoryItem(
                          title: controller.categories[index]['libelle'],
                          index: index,
                          controller: controller,
                          onTap: () async {await controller.changeSelectedCategory(index); }),
                    ),
                  ]),
                ),
                const SizedBox(height: kDefaultMargin * 2.2),
                Row(
                  children: [
                    const TitleText(title: "Médicaments"),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.MEDICAMENTS);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Voir plus",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultMargin * 1.3),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.medicamentsList.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kTextColor),
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
            ),
          ),
        );
      }),
    );
  }

  AppBar buildAppBar(HomeScreenController controller) {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
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


