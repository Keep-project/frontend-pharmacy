import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/inventaire/inventaire.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/search_custom_button.dart';

class InventaireScreen extends GetView<InventaireController> {
  const InventaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GetBuilder<InventaireController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: buildAppBar(
            controller,
            context,
          ),
          drawer: const AppNavigationDrawer(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                SearchBarAndButton(
                    context: context,
                    controller: controller,
                    onChanged: (data) async {
                      await controller.searchData(data);
                    },
                    onTap: () async {
                      unfocus();
                    }),
                const SizedBox(height: kDefaultMargin * 2.8),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 30,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                          "assets/icons/Icon material-card-giftcard.svg",
                          fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 5),
                    const TitleText(title: "Liste des inventaires"),
                  ],
                ),
                const SizedBox(height: kDefaultMargin * 1.6),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.inventairesList.isEmpty
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
                                  controller.inventairesList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: InkWell(
                                      onTap: () { Get.toNamed(AppRoutes.DETAIL_INVENTAIRES, arguments: controller.inventairesList[index]); },
                                      child: CardContainer(
                                        header: Row(
                                          children: [
                                            Text(controller.inventairesList[index].libelle!.capitalizeFirst!,
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
                                                    "assets/icons/Icon material-card-giftcard.svg",
                                                    height: 14,
                                                    width: 14),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Ref: ${controller.inventairesList[index].id!.toString().padLeft(2, '0')}",
                                                  style: TextStyle(
                                                    color: kDarkColor
                                                        .withOpacity(0.9),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        body: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            MyRow(
                                              title: "Entrepôt",
                                              value: controller.inventairesList[index].entrepotName!.toString().capitalizeFirst,
                                            ),
                                            MyRow(
                                              title: "Date",
                                              value: "${controller.inventairesList[index].createdToString()} à ${controller.inventairesList[index].hourToString()}",
                                            ),
                                            Row(
                                              children: [
                                                const Spacer(),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal:
                                                              kDefaultPadding,
                                                          vertical:
                                                              kDefaultPadding /
                                                                  3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultRadius * 3),
                                                    color: kTextColor2
                                                        .withOpacity(0.12),
                                                  ),
                                                  child: const Text(
                                                    "Clôturé",
                                                    style: TextStyle(
                                                      color: kTextColor2,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
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
                controller.inventairesList.isEmpty &&
                        controller.infinityStatus == LoadingStatus.completed
                    ? Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 2),
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Text(
                            "Ooops !!!\nVous n'avez encore aucun inventaire enregistré ici",
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

  AppBar buildAppBar(InventaireController controller, BuildContext context) {
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
      title: const Text(
        "Inventaires",
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
                child: Icon(Icons.menu, size: 30, color: kWhiteColor)),
          ),
        ),
      ],
    );
  }
}

class MyRowIcon extends StatelessWidget {
  final String? title;
  final String? value;
  const MyRowIcon({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: TextStyle(
            color: kDarkColor.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            SvgPicture.asset("assets/icons/Composant 54 – 1.svg"),
            const SizedBox(width: 3),
            Text(
              value!,
              style: const TextStyle(
                color: kDarkColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding - 4),
      ],
    );
  }
}
