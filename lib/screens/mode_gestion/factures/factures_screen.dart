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
import 'package:pharmacy_app/screens/mode_gestion/factures/factures.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/search_custom_button.dart';

class FactureScreen extends GetView<FactureController> {
  const FactureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
    void unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GetBuilder<FactureController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          key: controller.facturationScaffoldKey,
          appBar: buildAppBar(controller),
          drawer: AppNavigationDrawer(children: controller.drawerItems,),
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
                          "assets/icons/Icon awesome-money-bill-alt.svg",
                          fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 5),
                    const TitleText(title: "Liste des factures"),
                  ],
                ),
                const SizedBox(height: kDefaultMargin * 1.6),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.facturesList.isEmpty
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
                                  controller.facturesList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: InkWell(
                                      onTap: () { Get.toNamed(AppRoutes.DETAIL_FACTURES, arguments: controller.facturesList[index]);},
                                      child: CardContainer(
                                        header: Row(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/icons/Icon feather-download.svg",
                                                    height: 18,
                                                    width: 18),
                                                const SizedBox(width: 5),
                                                Text("CODE-FAC: ${controller.facturesList[index].id.toString().padLeft(2, '0')}",
                                                  style: TextStyle(
                                                    color: kDarkColor
                                                        .withOpacity(0.9),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Créee le ${controller.facturesList[index].createdToString()}}",
                                                  style: TextStyle(
                                                    color: kDarkColor
                                                        .withOpacity(0.9),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "Par: ${controller.facturesList[index].username!.capitalizeFirst!}",
                                                  style: TextStyle(
                                                    color: kDarkColor
                                                        .withOpacity(0.4),
                                                    fontSize: 12,
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
                                              title: "Montant HT",
                                              value: "${controller.facturesList[index].montantTotal} F",
                                            ),
                                            MyRow(
                                              title: "Montant TTC",
                                              value: "${controller.facturesList[index].montantTotal} F",
                                            ),
                                            MyRow(
                                              title: "Date d'échéance",
                                              value: controller.facturesList[index].createdToString(),
                                              color: kOrangeColor,
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
                                                    "Payée",
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
                controller.facturesList.isEmpty &&
                        controller.infinityStatus == LoadingStatus.completed
                    ? Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 2),
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Text(
                            "Ooops !!!\nVous n'avez encore aucune facture enregistrée ici",
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

  AppBar buildAppBar(FactureController controller) {
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
        "Factures clients",
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
          ),),
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
