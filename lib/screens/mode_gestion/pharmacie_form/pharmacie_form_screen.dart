
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/mode_gestion/pharmacie_form/pharmacie_form.dart';

class PharmacieFormScreen extends GetView<PharmacieFormScreenController> {
  const PharmacieFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PharmacieFormScreenController>(builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height-24,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  "assets/images/Symbols.png",
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      height: Get.height-24,
                      child: PageView.builder(
                        physics: Get.arguments == null
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          // controller.onChangePage(value);
                        },
                        itemCount: controller.pages.length,
                        controller: controller.pageController,
                        itemBuilder: (context, index) =>
                            controller.pages[index],
                      )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
