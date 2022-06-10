import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/details/details.dart';

class DetailScreen extends GetView<DetailScreenController> {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<DetailScreenController>(builder: (controller) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: Get.height,
                width: Get.width,
              ),
              Container(
                height: 250,
                width: Get.width,
                padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/comprime1.jpg"),
                  ),
                ),
              ),
              Positioned(
                left: kDefaultPadding,
                top: 170,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Doliprane 200mg\n",
                        style: TextStyle(
                          color: kDarkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Fabriquant: Denk",
                        style: TextStyle(
                          color: kOrangeColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: kDefaultPadding,
                top: kDefaultPadding,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: const Icon(CupertinoIcons.arrow_left,
                        color: kDarkColor, size: 30),
                  ),
                ),
              ),
              Positioned(
                top: 220,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kDefaultRadius * 3),
                      topRight: Radius.circular(kDefaultRadius * 3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -10),
                        blurRadius: 5,
                        color: kDarkColor.withOpacity(0.022),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: const [
                                  Icon(Icons.room,
                                      color: kOrangeColor, size: 20),
                                  Text(
                                    "Yaoundé, Cameroun",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kDarkColor,
                                    ),
                                  ),
                                ]),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Prix: 1250F",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kDarkColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "200mg",
                                  style: TextStyle(
                                    color: kDarkColor,
                                  ),
                                ),
                                Text(
                                  "Exp: 12/03/2010",
                                  style: TextStyle(
                                    color: kDarkColor,
                                  ),
                                ),
                                Text(
                                  "Stock: 120",
                                  style: TextStyle(
                                    color: kDarkColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultMargin * 3),
                        const TitleText(title: "Description"),
                        const SizedBox(height: kDefaultMargin),
                        Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit.Perferendis suscipit, fugit illo minus dolore repellat quam expedita voluptatum temporibus sequi maxime consequuntur, porro ducimus dolores recusandae labore vel excepturi vero tenetur esse accusantium ratione voluptatibus aperiam! Eligendi a consequatur iste fuga, sunt, vitae porro fugit expedita obcaecati quia non voluptate hic ipsum amet dignissimos, saepe excepturi sint alias magnam accusantium distinctio ut libero nihil! Amet placeat voluptate unde enim possimus sapiente deserunt obcaecati voluptatum nulla mollitia voluptatibus esse id et exercitationem a illo perferendis explicabo accusamus eos dicta, inventore, velit rem quos? Aut officia ncessitatibus aspernatur culpa, tempore nostrum debitis?",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.4),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: kDefaultMargin / 2),
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(height: kDefaultMargin),
                        const TitleText(title: "Posologie"),
                        Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit.Perferendis suscipit, fugit illo minus dolore repellat quam expedita voluptatum temporibus",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.4),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: kDefaultMargin * 3),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleText(title: " Localisation"),
                                Row(children: const [
                                  Icon(Icons.room,
                                      color: kOrangeColor, size: 20),
                                  Text(
                                    "Yaoundé, Cameroun",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kOrangeColor,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.MAPVIEW);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding / 1.5,
                                      vertical: kDefaultPadding / 2),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius / 1.3),
                                    color: kTextColor2,
                                  ),
                                  child: const Text(
                                    "Voir sur la map",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kWhiteColor,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultMargin * 3),
                        const TitleText(
                            title: "Vous trouverez Doliprane 200mg à:"),
                        const SizedBox(height: kDefaultMargin * 1.5),
                        const PharmacyCard(
                          name: "Pharmacie de Medong",
                          phone: "Tel: +237 652 310 829",
                          stock: 45,
                          status: "Ouverte",
                        ),
                        const PharmacyCard(
                          name: "Pharmacie de TKC",
                          phone: "Tel: +237 652 310 829",
                          stock: 83,
                          status: "Fermée",
                        ),
                        const PharmacyCard(
                          name: "Pharmacie de Biyem-Assi",
                          phone: "Tel: +237 652 310 829",
                          stock: 72,
                          status: "Ouverte",
                        ),
                        const PharmacyCard(
                          name: "Pharmacie de Nlongkak",
                          phone: "Tel: +237 652 310 829",
                          stock: 31,
                          status: "Ouverte",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class PharmacyCard extends StatelessWidget {
  final String name;
  final String phone;
  final int stock;
  final String status;
  const PharmacyCard({
    Key? key, required this.name, required this.phone, required this.stock, required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhiteColor,
      elevation: 2,
      shadowColor: kTextColor.withOpacity(.4),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: kDefaultMargin),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(kDefaultRadius)),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: [
            const Icon(CupertinoIcons.gift_fill,
                color: kTextColor2, size: 55),
            const SizedBox(width: kDefaultPadding / 1.5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                  style: const TextStyle(
                    color: kDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(phone,
                  style: const TextStyle(
                    color: kDarkColor,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "Stock: $stock",
                      style: const TextStyle(
                        color: kDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                      Text(status,
                      style: const TextStyle(
                        color: kOrangeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}