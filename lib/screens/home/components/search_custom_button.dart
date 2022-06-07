// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';


class SearchBarAndButton extends StatelessWidget {
  final BuildContext context;
  const SearchBarAndButton({
    Key? key, required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kGreyColor,
              borderRadius:
                  BorderRadius.circular(kDefaultPadding * 2),
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
            showDialog(context: context, builder: (context) => const FilterDialog());
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
      backgroundColor:  kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius*2)),
      alignment: Alignment.topRight,
      child: Container(
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(kDefaultPadding),
      ),
    );
  }
}
