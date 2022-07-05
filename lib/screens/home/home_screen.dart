// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/home/components/category_item.dart';
import 'package:pharmacy_app/screens/home/components/medicament_card.dart';
import 'package:pharmacy_app/screens/home/components/search_custom_button.dart';
import 'package:pharmacy_app/screens/home/home.dart';

import '../../core/app_state.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeScreenController>(builder: (controller) {
        return Scaffold(
          appBar: buildAppBar(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const ActionsDialog());
              },
              backgroundColor: kTextColor2,
              child: const Icon(Icons.add, color: kWhiteColor, size: 36)),
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
                    text: "PharmaCam",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ])),
                const SizedBox(height: kDefaultPadding - 4),
                SearchBarAndButton(context: context),
                const SizedBox(height: kDefaultMargin * 2.2),
                const TitleText(title: "Catégories"),
                const SizedBox(height: kDefaultMargin * 1.6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    CategoryItem(title: "Tous", onTap: () {}),
                    CategoryItem(title: "Adolescents", onTap: () {}),
                    CategoryItem(title: "Enfants", onTap: () {}),
                    CategoryItem(title: "Adultes", onTap: () {}),
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
                const SizedBox(height: kDefaultMargin * 1.5),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.medicamentsList.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kTextColor2),
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
                                  controller.medicamentsList.length, (index) => const MedicamentCard()),

                              controller.infinityStatus ==
                                      LoadingStatus.searching
                                  ? Container(
                                      padding: const EdgeInsets.all(0),
                                      height: 220,
                                      width: Get.width / 2 - 32,
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
                      controller.medicamentsList.isEmpty 
                      && controller.infinityStatus == LoadingStatus.completed ?
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Ooops !!!\nAucun livre trouvé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:  kGreyColor.withOpacity(0.7),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ) : Container(),
              ],
            ),
          ),
        );
      }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: const Padding(
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: Center(
          child: Text(
            "OC",
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
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

class ActionsDialog extends StatelessWidget {
  const ActionsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius * 1.3)),
      alignment: Alignment.center,
      child: Container(
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Actions",
              style: TextStyle(
                color: kTextColor2,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              thickness: 1.7,
            ),
            const SizedBox(
              height: kDefaultMargin,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.PHARMACIEFORM);
              },
              child: Row(
                children: [
                  const Text(
                    "Ajouter une pharmacie",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: kTextColor2,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: kWhiteColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultMargin * 1.5),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.MEDICAMENTSFORM);
              },
              child: Row(
                children: [
                  const Text(
                    "Ajouter un médicament",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: kTextColor2,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: kWhiteColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultMargin),
          ],
        ),
      ),
    );
  }
}
