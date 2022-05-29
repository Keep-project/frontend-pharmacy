// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            height: Get.height,
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                const Text(
                  "Connexion",
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
                const SizedBox(height: kDefaultPadding),
                CustomTextField(
                  onChanged: (string) {
                    print(string);
                  },
                  onTap:(){},
                  hintText: "Entrez votre email",
                  iconData: CupertinoIcons.mail_solid,
                ),
                const SizedBox(height: kDefaultPadding),
                CustomTextField(
                  onChanged: (string) {
                    print(string);
                  },
                  onTap:(){print("show password");},
                  hintText: "Entrez votre mot de passe",
                  iconData: CupertinoIcons.eye_fill,
                ),
                const Spacer(),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kTextColor,
                    borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                  ),
                  child: const Center(
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(
                        color: kColorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding*4,),
                Row(
                  children: [
                    const Text(
                      "Avez-vous un compte? ",
                      style: TextStyle(
                        color: kDarkColor,
                        // fontSize: 16,
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
                            // fontSize: 16,
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

class CustomTextField extends StatelessWidget {
  final Function(String string)? onChanged;
  final String? hintText;
  final IconData? iconData;
  final Function()? onTap;
  const CustomTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.iconData, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1.5,
          color: kTextColor,
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
      ),
      child: TextField(
        onChanged: (String value) {
          onChanged!(value);
        },
        decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: (){onTap!();},
              child: Icon(iconData!, color: kTextColor)),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
                left: 10, top: 16, bottom: 16, right: 10)),
      ),
    );
  }
}
