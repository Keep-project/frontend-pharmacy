import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/screens/medicament_form/medicament_form_controller.dart';

class MedicamentFormScreen extends GetView<MedicamentFormScreenController> {
  const MedicamentFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MedicamentFormScreenController>(
          builder: (controller){
            return Container(
              padding: const EdgeInsets.all(0),
              child: const Center(
                child: Text("Formulaire de creation de médicament"),
              )
            );
          },
        ),
      ),
    );
  }
}