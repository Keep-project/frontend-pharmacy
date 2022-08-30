import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/models/response_data_models/medicament_model.dart';
import 'package:pharmacy_app/router/app_router.dart';

class MedicamentCard extends StatelessWidget {
  final Medicament medicament;
  const MedicamentCard({
    Key? key,
    required this.medicament,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.DETAILS, arguments: medicament.id.toString());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultMargin * 1.5),
        padding: const EdgeInsets.all(5),
        height: 220,
        width: Get.width / 2 - 32,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 20,
              color: kTextColor.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: medicament.id.toString(),
                    child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: kGreyColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(medicament.photo!),
                            ))),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kTextColor2.withOpacity(.8),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                          ),
                        ),
                        child: Text(
                          "${medicament.prix!} FCFA",
                          style: const TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(45, 0, 0, 0),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.room, color: kOrangeColor, size: 16),
                            Text(
                              "Yaoundé, Cameroun",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicament.nom!.toString().capitalizeFirst!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      medicament.pharmaciename!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Row(children: [
                      const Spacer(),
                      Text(
                        medicament.masse!,
                        style: const TextStyle(
                          color: kOrangeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
