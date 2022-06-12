import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/search_bar.dart';
import 'package:pharmacy_app/components/title_text.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/rendez_vous/rendez_vous.dart';

class RendezVousScreen extends GetView<RendezVousScreenController> {
  const RendezVousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<RendezVousScreenController>(builder: (controller) {
          return Container(
            padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding * 1.5,),
                  const SearchBar(),
                  const SizedBox(height: kDefaultMargin * 2),
                  const TitleText(title: "Catégories"),
                  const SizedBox(height: kDefaultMargin * 1.5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        SpecialityCard(
                            assetName: "assets/images/icon-dentist.svg",
                            title: "Dentiste",
                            number: 03),
                        SpecialityCard(
                            assetName: "assets/images/icon-brain.svg",
                            title: "Cerveau",
                            number: 05),
                        SpecialityCard(
                          assetName: "assets/images/icon-heart.svg",
                          title: "Coeur",
                          number: 08,
                        ),
                        SpecialityCard(
                          assetName: "assets/images/icon-bone.svg",
                          title: "Os",
                          number: 04,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultMargin * 2),
                  Row(
                    children: [
                      const TitleText(title: "Nos docteurs"),
                      const Spacer(),
                      Text(
                        "Voir plus",
                        style: TextStyle(
                          color: kDarkColor.withOpacity(.4),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kTextColor2,
      leading: const Padding(
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: Icon(Icons.menu, size: 30, color: kWhiteColor),
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

class SpecialityCard extends StatelessWidget {
  final String assetName;
  final String title;
  final int number;
  const SpecialityCard({
    Key? key,
    required this.assetName,
    required this.title,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 117,
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      margin: const EdgeInsets.only(right: kDefaultMargin * 1.6),
      decoration: BoxDecoration(
        color: kTextColor2.withOpacity(0.9),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: Column(
        children: [
          Container(
            height: 45,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: SvgPicture.asset(
              assetName,
              fit: BoxFit.fill,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 4),
              decoration: BoxDecoration(
                  color: kTextColor2,
                  borderRadius: BorderRadius.circular(kDefaultRadius / 2)),
              child: Text(
                "$number Docteurs",
                style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }
}
