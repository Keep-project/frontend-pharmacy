import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/pharmacie_form/pharmacie_form.dart';

class PharmacieFormScreen extends GetView<PharmacieFormScreenController> {
  const PharmacieFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<PharmacieFormScreenController>(
          builder: (controller){
            return Container(
              padding: const EdgeInsets.all(0),
              child: const Center(
                child: Text("Formulaire de creation de pharmacie"),
              )
            );
          },
        ),
      ),
    );
  }
}