
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class CustomDropDown extends StatelessWidget {
  final dynamic controller;
  final List liste;
  final String selectedItem;
  final Function(dynamic data) onChanged;
  final String helpText;
  const CustomDropDown({
    Key? key,
    required this.controller,
    required this.liste,
    required this.selectedItem,
    required this.onChanged,
    required this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.6,
          child: Text(
            helpText,
            style: const TextStyle(
              fontSize: 16,
              color: kDarkColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          decoration: BoxDecoration(
            color: kWhiteColor,
              border: Border.all(
                width: 1.2,
                color: kTextColor2.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<dynamic>(
            value: selectedItem,
            icon: const Icon(CupertinoIcons.chevron_down, size: 20),
            elevation: 16,
            isExpanded: true,
            style:
                TextStyle(color: kDarkColor.withOpacity(0.7), fontSize: 16),
            underline: Container(
              height: 0,
              width: 0,
              color: kDarkColor,
            ),
            onChanged: (dynamic newValue) {
              onChanged(newValue);
            },
            items: liste.map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value['libelle'],
                child: Text(value['libelle']),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
