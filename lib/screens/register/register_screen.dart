// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height-24,
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kDefaultMargin,),
                IconButton(
                  onPressed: (){Get.back();},
                  icon: const Icon(CupertinoIcons.arrow_left, size: 36, color: kTextColor),
                ),
                const Spacer(),
                const Text(
                  "Créer un compte",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 2),
                CustomTextField(
                  onChanged: (string) {
                    print(string);
                  },
                  onTap:(){},
                  hintText: "Entrez votre nom",
                  iconData: CupertinoIcons.person_fill,
                ),
                const SizedBox(height: kDefaultPadding*1.5),
                CustomTextField(
                  onChanged: (string) {
                    print(string);
                  },
                  onTap:(){},
                  hintText: "Entrez votre email",
                  iconData: CupertinoIcons.mail_solid,
                ),
                
                const SizedBox(height: kDefaultPadding*1.5),
                CustomTextField(
                  onChanged: (string) {
                    print(string);
                  },
                  onTap:(){print("show password");},
                  hintText: "Entrez votre mot de passe",
                  iconData: CupertinoIcons.eye_fill,
                ),
                const Spacer(),
                InkWell(
                  onTap: (){Get.toNamed(AppRoutes.LOGIN);},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kTextColor,
                      borderRadius: BorderRadius.circular(kDefaultRadius - 2),
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
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


