import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/mouvement_stock/mouvement_stock.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/search_custom_button.dart';

class MouvementStockScreen extends GetView<MouvementStockController> {
  const MouvementStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MouvementStockController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kDefaultPadding),
                SearchBarAndButton(
                    context: context, controller: controller, onTap: () {}),
                const SizedBox(height: kDefaultMargin * 2.8),
                const TitleText(
                  title: "Liste des mouvements de stock",
                ),
                const SizedBox(height: kDefaultPadding),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.mouvementStockList.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kTextColor),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  controller.mouvementStockList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kDefaultPadding / 2),
                                    child: CardContainer(
                                      header: Row(
                                        children: [
                                          Text(
                                            controller.mouvementStockList[index]
                                                .entrepotName!.capitalizeFirst!,
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/Icon map-moving-company.svg",
                                                  height: 10,
                                                  width: 10),
                                              const SizedBox(width: 5),
                                              Text(
                                                "Ref: ${controller.mouvementStockList[index].id!.toString().padLeft(2, '0')}",
                                                style: TextStyle(
                                                  color: kDarkColor
                                                      .withOpacity(0.9),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      body: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                              height: kDefaultPadding / 2),
                                          Text(
                                            controller.mouvementStockList[index]
                                                .description!,
                                            style: TextStyle(
                                              color:
                                                  kDarkColor.withOpacity(0.9),
                                              fontSize: 12,
                                              height: 1.3,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          const SizedBox(
                                              height: kDefaultPadding / 1.5),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Quantité: ",
                                                    style: TextStyle(
                                                      color: kDarkColor
                                                          .withOpacity(0.6),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(controller.mouvementStockList[index].quantite!.toString(),
                                                    style: TextStyle(
                                                      color: kTextColor2
                                                          .withOpacity(0.9),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                "${controller.mouvementStockList[index].createdToString()} à ${controller.mouvementStockList[index].hourToString()}",
                                                style: TextStyle(
                                                  color: kTextColor2
                                                      .withOpacity(0.9),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kDefaultPadding / 2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                                const SizedBox(height: kDefaultMargin * 1.8),
                              ]),
                        ),
                      ),
                controller.mouvementStockList.isEmpty &&
                        controller.infinityStatus == LoadingStatus.completed
                    ? Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 2),
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Text(
                            "Ooops !!!\nVous n'avez encore aucun mouvement de stock sur ce produit",
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
        ),
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
      title: const Text(
        "Mouvements de stock",
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
