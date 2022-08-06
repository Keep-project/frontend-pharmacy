import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/router/app_router.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({Key? key}) : super(key: key);

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
                height: 190,
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
                      padding: const EdgeInsets.only(left: kDefaultPadding * 1.5, top: kDefaultPadding*2),
                  child: Column(
                    children: [
                      DrawerMenuItem(
                        title: "Accueil",
                        iconData: Icons.home_outlined,
                        onTap: () {
                          Get.offAndToNamed(AppRoutes.HOME);
                        },
                      ),
                      DrawerMenuItem(
                        title: "Dashbord",
                        iconData: Icons.dashboard_outlined,
                        onTap: () {Get.offAndToNamed(AppRoutes.DASHBORD);},
                      ),
                      DrawerMenuItem(
                        title: "Stocks",
                        iconData: CupertinoIcons.gift_alt_fill,
                        onTap: () {Get.offAndToNamed(AppRoutes.STOCK);},
                      ),
                      DrawerMenuItem(
                        title: "Factures",
                        iconData: Icons.dashboard_outlined,
                        onTap: () {Get.offAndToNamed(AppRoutes.FACTURES);},
                      ),
                      DrawerMenuItem(
                        title: "Inventaire",
                        iconData: Icons.dashboard_outlined,
                        onTap: () {Get.offAndToNamed(AppRoutes.INVENTAIRES);},
                      ),
                      DrawerMenuItem(
                        title: "Entrepôt/Magasin",
                        iconData: Icons.warehouse_rounded,
                        onTap: () {Get.offAndToNamed(AppRoutes.ENTREPOT);},
                      ),
                    ],
                  ),      
                )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("By KENNE TCHINDA & KUE KONGNE", 
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
    Key? key, this.title, this.iconData, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding* 0.9),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(iconData, color: kTextColor2.withOpacity(0.4), size: 24,),
            const SizedBox(width: kDefaultPadding/2),
            Text(title!,
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
