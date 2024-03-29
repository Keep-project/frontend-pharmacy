import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';
import 'package:pharmacy_app/services/local_services/authentication/authentification.dart';

class AppNavigationDrawer extends StatelessWidget {
  final List<Widget>? children;
  const AppNavigationDrawer({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.65,
      child: Container(
        height: Get.height,
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
                height: 170,
                decoration: const BoxDecoration(
                  color: kTextColor2,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      kTextColor2,
                      kTextColor2,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("assets/images/onboarding_two.jpg"),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Pharmacie du Soleil",
                        style: TextStyle(
                          color: kWhiteColor.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "pharmaciedusoleil@gmail.com",
                        style: TextStyle(
                          color: kWhiteColor.withOpacity(0.4),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Text("Tel: +237 652 310 829",
                      //   style: TextStyle(
                      //     color: kWhiteColor.withOpacity(0.4),
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      const Spacer(),
                    ],
                  ),
                )),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding * 1.5, top: kDefaultPadding),
                child: Column(
                  children: [
                    ...children!,
                    DrawerMenuItem(
                      title: "Pharmacies",
                      iconData: Icons.dashboard_outlined,
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.MAPVIEW);
                      },
                    ),
                    const SizedBox(height: kDefaultPadding * 2),
                    const Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding * 2),
                      child: Divider(
                        thickness: 0.9,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DrawerMenuItem(
                      title: "Se déconnecter",
                      iconData: Icons.power_off,
                      onTap: () async {
                        final LocalAuthentificationService _localAuth =
                            LocalAuthentificationServiceImpl();
                        await _localAuth.deleteToken();
                        Get.offAllNamed(AppRoutes.LOGIN);
                      },
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "By KENNE TCHINDA & KUE KONGNE",
                style: TextStyle(
                  fontSize: 10,
                  color: kDarkColor.withOpacity(0.4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final Function()? onTap;
  const DrawerMenuItem({
    Key? key,
    this.title,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 0.9),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              iconData,
              color: kTextColor2.withOpacity(0.4),
              size: 24,
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kDarkColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
