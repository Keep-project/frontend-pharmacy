import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/card_container.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/details/details_screen.dart';
import 'package:pharmacy_app/screens/home/components/search_custom_button.dart';
import 'package:pharmacy_app/screens/stocks/stock.dart';

class StockScreen extends GetView<StockController> {
  const StockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                SearchBarAndButton(
                    context: context, controller: controller, onTap: () {}),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardContainer(
                            header: Row(
                              children: const [
                                Text(
                                  "Doliprane 100mg",
                                  style: TextStyle(
                                    color: kDarkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Ref: P001",
                                  style: TextStyle(
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
                                const MyRow(
                                  title: "Stock limite pour alerte",
                                  value: "15",
                                  color: kOrangeColor,
                                ),
                                const MyRow(
                                  title: "Stock désiré optimal",
                                  value: "100",
                                ),
                                const MyRowIcon(
                                  title: "Stock physique",
                                  value: "12",
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
                                        '1700 Fcfa',
                                        style: TextStyle(
                                          color: kTextColor2.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    const Spacer(),
                                    Container(
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
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultMargin * 1.8),
                          CardContainer(
                            header: Row(
                              children: const [
                                Text(
                                  "Paracétamol 500mg",
                                  style: TextStyle(
                                    color: kDarkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Ref: P001",
                                  style: TextStyle(
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
                                const MyRow(
                                  title: "Stock limite pour alerte",
                                  value: "15",
                                  color: kOrangeColor,
                                ),
                                const MyRow(
                                  title: "Stock désiré optimal",
                                  value: "100",
                                ),
                                const MyRow(
                                  title: "Stock physique",
                                  value: "83",
                                ),
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
                                        '1700 Fcfa',
                                        style: TextStyle(
                                          color: kTextColor2.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    const Spacer(),
                                    Container(
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
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultMargin * 1.8),
                          CardContainer(
                            header: Row(
                              children: const [
                                Text(
                                  "Paracétamol 500mg",
                                  style: TextStyle(
                                    color: kDarkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Ref: P001",
                                  style: TextStyle(
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
                                const MyRow(
                                  title: "Stock limite pour alerte",
                                  value: "15",
                                  color: kOrangeColor,
                                ),
                                const MyRow(
                                  title: "Stock désiré optimal",
                                  value: "100",
                                ),
                                const MyRow(
                                  title: "Stock physique",
                                  value: "83",
                                ),
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
                                        '1700 Fcfa',
                                        style: TextStyle(
                                          color: kTextColor2.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    const Spacer(),
                                    Container(
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
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 2),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
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