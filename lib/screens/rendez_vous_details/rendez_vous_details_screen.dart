
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/rendez_vous_details/rendez_vous_details.dart';

class RendezVousScreenDetails extends GetView<RendezVousScreenControllerDetails> {
  const RendezVousScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<RendezVousScreenControllerDetails>(
          builder: (context) {
            return Container(
              child: const Center(
                child: Text("Rendez vous / details")
              ),
            );
          }
        ),
      ),
    );
  }
}