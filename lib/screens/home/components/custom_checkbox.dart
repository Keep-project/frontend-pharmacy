import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';

class CheckBoxComponent extends StatelessWidget {
  const CheckBoxComponent({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final dynamic controller;
  final int? index;

  @override
  Widget build(BuildContext context) {
    RxBool check = false.obs;
    return Obx(
      () => Container(
        width: Get.width / 3.2,
        height: 40,
        decoration: const BoxDecoration(),
        child: Row(children: [
          Checkbox(
              side: const BorderSide(width: 1, color: kTextColor2),
              activeColor: kTextColor2,
              value: check.value,
              onChanged: (bool? val) {
                check.value = val!;
                controller.changeVoix(index);
              }),
          Text(controller.voix[index]['libelle'],
              style:
                  TextStyle(fontSize: 16, color: kDarkColor.withOpacity(.7))),
        ]),
      ),
    );
  }
}
