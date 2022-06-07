// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class SearchBarAndButton extends StatelessWidget {
  final BuildContext context;
  const SearchBarAndButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.circular(kDefaultPadding * 2),
            ),
            child: TextField(
              onChanged: (String string) {},
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  hintText: "Rechercher...",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.4),
                    fontSize: 16,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      print("Search");
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: kGreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: Icon(CupertinoIcons.search,
                              size: 30, color: kTextColor)),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding - 4, vertical: 12)),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            showDialog(
                context: context, builder: (context) => const FilterDialog());
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
                child: Icon(CupertinoIcons.sort_down,
                    size: 30, color: kTextColor)),
          ),
        ),
      ],
    );
  }
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius)),
      alignment: Alignment.topRight,
      child: Container(
        height: 430,
        width: 300,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filtre",
              style: TextStyle(
                fontSize: 20,
                color: kTextColor2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: kDefaultMargin / 2),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: kDefaultMargin * 1.5),
            Text(
              "catégorie",
              style: TextStyle(
                color: kTextColor2.withOpacity(.6),
              ),
            ),
            const SizedBox(height: kDefaultMargin * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomButton(
                    libelle: "Tous",
                    color: kWhiteColor,
                    backgroundColor: kTextColor2),
                CustomButton(
                    libelle: "Enfants",
                    color: kTextColor2,
                    backgroundColor: kWhiteColor),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding * .7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomButton(
                    libelle: "Adoles.",
                    color: kTextColor2,
                    backgroundColor: kWhiteColor),
                CustomButton(
                    libelle: "Adultes",
                    color: kTextColor2,
                    backgroundColor: kWhiteColor),
              ],
            ),
            const SizedBox(height: kDefaultMargin),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: kDefaultMargin - 4),
            Text(
              "voie de prise",
              style: TextStyle(
                color: kTextColor2.withOpacity(.6),
              ),
            ),
            const SizedBox(height: kDefaultPadding / 6),
            Row(
              children: [
                Row(children: [
                  Checkbox(
                      side: const BorderSide(width: 1, color: kTextColor2),
                      activeColor: kTextColor2,
                      value: true,
                      onChanged: (bool? val) {
                        print(val);
                      }),
                  Text("Orale",
                      style: TextStyle(
                          fontSize: 16, color: kDarkColor.withOpacity(.7))),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                          side: const BorderSide(width: 1, color: kTextColor2),
                          activeColor: kTextColor2,
                          value: false,
                          onChanged: (bool? val) {
                            print(val);
                          }),
                      Text("Anale",
                          style: TextStyle(
                              fontSize: 16, color: kDarkColor.withOpacity(.7))),
                    ]),
              ],
            ),
            Row(children: [
              Checkbox(
                  side: const BorderSide(width: 1, color: kTextColor2),
                  activeColor: kTextColor2,
                  value: false,
                  onChanged: (bool? val) {
                    print(val);
                  }),
              Text("Injection",
                  style: TextStyle(
                      fontSize: 16, color: kDarkColor.withOpacity(.7))),
            ]),
            const SizedBox(height: kDefaultMargin),
            GestureDetector(
              onTap: () {print("Rechercher");},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kTextColor2,
                  border: Border.all(
                    width: 1.2,
                    color: kTextColor2,
                  ),
                  borderRadius: BorderRadius.circular(kDefaultRadius - 4),
                ),
                child: const Center(
                  child: Text(
                    'Rechercher',
                    style: TextStyle(
                      fontSize: 16,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String libelle;
  final Color color;
  final Color backgroundColor;
  const CustomButton({
    Key? key,
    required this.libelle,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: 1.2,
          color: kTextColor2,
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius - 4),
      ),
      child: Center(
        child: Text(
          libelle,
          style: TextStyle(
            fontSize: 16,
            color: color,
          ),
        ),
      ),
    );
  }
}
