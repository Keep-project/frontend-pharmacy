// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/components/custom_text_field.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                const Spacer(),
                const Text(
                  "Connexion",
                  style: TextStyle(
                    color: kTextColor2,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: kDefaultPadding*3,),
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
                  onTap:(){print("show password");},
                  hintText: "Entrez votre mot de passe",
                  iconData: CupertinoIcons.eye_fill,
                ),
                const SizedBox(height: kDefaultPadding*4),
                InkWell(
                  onTap: (){Get.toNamed(AppRoutes.HOME);},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kTextColor2,
                      borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                    ),
                    child: const Center(
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding*2,),
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
                      onTap: (){Get.toNamed(AppRoutes.REGISTER);},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical:8.0),
                        child: Text(
                          "Créer un compte",
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
      ),
    );
  }
}
