
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/my_row.dart';
import 'package:pharmacy_app/components/my_row_icon.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_drawer.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/mode_gestion/stocks/stock.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/custom_action_dialog.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/search_custom_button.dart';

class StockScreen extends GetView<StockController> {
  const StockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
      void unfocus() {
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    return GetBuilder<StockController>(
      
      builder: (controller) => SafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: buildAppBar(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const ActionsDialog());
              },
              backgroundColor: kTextColor2,
              child: const Icon(Icons.add, color: kWhiteColor, size: 36)),
          drawer: const AppNavigationDrawer(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                SearchBarAndButton(
                  context: context,
                  controller: controller,
                  onChanged: (data)async{ await controller.searchData(data); },
                  onTap: () async {
                    unfocus();
                  }
                ),
                const SizedBox(height: kDefaultMargin * 2.8),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 30,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset("assets/icons/warehouse.svg",
                          fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 5),
                    const TitleText(title: "Produits en stock"),
                  ],
                ),
                const SizedBox(height: kDefaultMargin * 1.6),
                controller.infinityStatus == LoadingStatus.searching &&
                        controller.medicamentsList.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kTextColor),
                        ),
                      )
                    : 
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate( controller.medicamentsList.length, (index) => 
                          Padding(
                            padding: const EdgeInsets.only(bottom: kDefaultPadding / 1.5),
                            child: InkWell(
                              onTap: () { Get.toNamed(AppRoutes.DETAILS_GESTION, arguments: controller.medicamentsList[index].id!.toString());},
                              child: CardContainer(
                                header: Row(
                                  children: [
                                    Text(controller.medicamentsList[index].nom!.capitalizeFirst!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: kDarkColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Ref: ${controller.medicamentsList[index].id!.toString().padLeft(2, '0')}",
                                      style: const TextStyle(
                                        color: kDarkColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                body: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    MyRow(
                                      title: "Stock limite pour alerte",
                                      value: controller.medicamentsList[index].stockAlert!.toString().padLeft(2, '0'),
                                      color: kOrangeColor,
                                    ),
                                    MyRow(
                                      title: "Stock désiré optimal",
                                      value: controller.medicamentsList[index].stockOptimal!.toString().padLeft(2, '0'),
                                    ),
                                    controller.medicamentsList[index].stock! <= controller.medicamentsList[index].stockAlert! ?
                                    MyRowIcon(
                                      title: "Stock physique",
                                      value: controller.medicamentsList[index].stock!.toString().padLeft(2, '0'),
                                    ): MyRow(
                                      title: "Stock physique",
                                      value: controller.medicamentsList[index].stock!.toString().padLeft(2, '0'),
                                    ),
                                    const SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                      children: [
                                        Row(children: [
                                          Text(
                                            'P.U vente: ',
                                            style: TextStyle(
                                              color: kDarkColor.withOpacity(0.7),
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '${controller.medicamentsList[index].prix!} Fcfa',
                                            style: TextStyle(
                                              color: kTextColor2.withOpacity(0.9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ]),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () { print("Liste des mouvements de stock");},
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding / 2,
                                                vertical: kDefaultPadding / 4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  kDefaultRadius * 3),
                                              color: kTextColor2.withOpacity(0.12),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/icons/Icon map-moving-company.svg",
                                                    height: 10,
                                                    width: 10),
                                                const SizedBox(width: 3),
                                                const Text(
                                                  "Mouvements",
                                                  style: TextStyle(
                                                    color: kTextColor2,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: kDefaultPadding / 2),
                                  ],
                                ),
                              ),
                            ),
                          ),),
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
                controller.medicamentsList.isEmpty &&
                        controller.infinityStatus == LoadingStatus.completed
                    ? Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
                        decoration: const BoxDecoration(),
                          width: double.infinity,
                          child: Text(
                            "Ooops !!!\nVous n'avez encore aucun médicament enregistré ici",
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


