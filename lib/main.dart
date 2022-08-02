import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/router/app_pages.dart';
import 'package:pharmacy_app/router/app_router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy CM',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.MOUVEMENT_PRODUIT,
    );
  }
}

