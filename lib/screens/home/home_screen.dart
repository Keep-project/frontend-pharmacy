import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhiteColor,
          leading: const  Center(child: Text("OC",
            style: TextStyle(
              color: kTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),),
          actions: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                color: kGreyColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          // color: Colors.red,
        ),
      ),
    );
  }
}