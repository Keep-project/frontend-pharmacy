
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}