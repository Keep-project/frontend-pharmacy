// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/search_bar.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/screens/mode_visiteur/home/components/custom_filter_dialog.dart';

class SearchBarAndButton extends StatelessWidget {
  final BuildContext context;
  final dynamic controller;
  final Function()? onTap;
  final Function(String data)? onChanged;
  const SearchBarAndButton({
    Key? key,
    required this.context,
    required this.controller,
    required this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentFocus;
      void unfocus() {
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    return Row(
      children: [
        Expanded(
          child: SearchBar(controller: controller.searchController, onTap: onTap, onChanged: onChanged),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            unfocus();
            showDialog(
                context: context,
                builder: (context) => FilterDialog(controller: controller));
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
