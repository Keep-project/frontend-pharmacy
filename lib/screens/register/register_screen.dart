// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/screens/register/register.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RegisterScreenController>(builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: Get.height - 24,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: kDefaultMargin,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(CupertinoIcons.arrow_left,
                        size: 36, color: kTextColor2),
                  ),
                  const Spacer(),
                  const Text(
                    "Créer un compte",
                    style: TextStyle(
                      color: kTextColor2,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  CustomTextField(
                    onChanged: (string) {
                      print(string);
                    },
                    controller: controller.textEditingNom,
                    onTap: () {},
                    hintText: "Entrez votre nom",
                    iconData: CupertinoIcons.person_fill,
                  ),
                  const SizedBox(height: kDefaultPadding * 1.5),
                  CustomTextField(
                    controller: controller.textEditingEmail,
                    onChanged: (string) {
                      print(string);
                    },
                    onTap: () {
                      print("show email");
                    },
                    hintText: "Entrez votre email",
                    iconData: CupertinoIcons.mail_solid,
                  ),
                  const SizedBox(height: kDefaultPadding * 1.5),
                  CustomTextField(
                    obscureText: controller.obscureText,
                    onChanged: (string) {
                      print(string);
                    },
                    controller: controller.textEditingPassword,
                    onTap: () {
                      controller.obscureText = !controller.obscureText;
                      controller.update();
                    },
                    hintText: "Entrez votre mot de passe",
                    iconData: controller.obscureText
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                  ),
                  const Spacer(),
                  controller.registerStatus == LoadingStatus.searching
                      ? Container(
                          height: 45,
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kOrangeColor,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async  {
                            await controller.register(context);
                          },  
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kTextColor2,
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius - 2),
                            ),
                            child: const Center(
                              child: Text(
                                "Enregistrer",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Avez-vous un compte? ",
                        style: TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.LOGIN);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "connectez-vous",
                            style: TextStyle(
                              color: kOrangeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
