import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_app/components/custom_dropdown.dart';
import 'package:pharmacy_app/components/custom_text_field2.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/screens/mode_gestion/medicament_form/medicament_form.dart';

class PageTwo extends GetView<MedicamentFormController> {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicamentFormController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: kDefaultPadding * 1.2),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField2(
                        onChanged: (string) {},
                        controller: controller.textEditingStockAlert,
                        textInputType: TextInputType.number,
                        title: "Stock limite pour alerte",
                        hintText: "Ex: 150",
                      ),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: CustomTextField2(
                        onChanged: (string) {},
                        controller: controller.textEditingStockOptimal,
                        textInputType: TextInputType.number,
                        title: "Stock désiré optimal",
                        hintText: "Ex: 400",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding - 4),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDown(
                        helpText: "Taux TVA",
                        controller: controller,
                        liste: controller.tvas,
                        selectedItem: controller.selectedTva,
                        onChanged: (data) {
                          controller.onChangeTva(data);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: CustomDropDown(
                        helpText: "Base de prix",
                        controller: controller,
                        liste: controller.baseprix,
                        selectedItem: controller.selectedBasePrix,
                        onChanged: (data) {
                          controller.onChangeBasePrix(data);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding - 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Opacity(
                            opacity: 0.6,
                            child: Text(
                              "Date d'expiration",
                              style: TextStyle(
                                fontSize: 16,
                                color: kDarkColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          CustomIconButton(
                            title: controller.datePremptionToString,
                            iconData: Icons.calendar_month,
                            onTap: () async {
                              DateTime? newdate = await showDatePicker(
                                context: context,
                                initialDate: controller.datePremption,
                                firstDate: DateTime(
                                    controller.datePremption.year - 10),
                                lastDate: DateTime(
                                    controller.datePremption.year + 10),
                              );
                              if (newdate == null) {
                                return;
                              }
                              controller.datePremptionToString =
                                  "${newdate.day.toString().padLeft(2, '0')}/${newdate.month.toString().padLeft(2, '0')}/${newdate.year}";
                              controller.datePremption = newdate;

                              controller.update();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Opacity(
                            opacity: 0.6,
                            child: Text(
                              "Ajouter une image",
                              style: TextStyle(
                                fontSize: 16,
                                color: kDarkColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          CustomIconButton(
                            title: controller.imageName,
                            iconData: Icons.camera_alt_outlined,
                            onTap: () async {
                              await controller.chooseImage(ImageSource.gallery);
                            },
                            onLongPress: () async {
                              await controller.chooseImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding - 4),
                controller.imageFile != null ? Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kTextColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(8),
                      image: controller.imageFile != null
                          ? DecorationImage(
                              image: FileImage(controller.imageFile),
                              fit: BoxFit.cover)
                          : null,
                    ),
                    child: const Center(
                      child:
                          Icon(Icons.camera_alt, size: 56, color: kDarkColor),
                    ),
                  ): Container(),
              ],
            ));
  }
}

class CustomIconButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;
  final Function()? onLongPress;
  const CustomIconButton({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: kTextColor2.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(kDefaultRadius - 2),
          ),
          child: Row(
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                ),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: kDarkColor.withOpacity(0.5),
                  ),
                ),
              ),
              const Spacer(),
              Icon(iconData, color: kDarkColor.withOpacity(0.3), size: 26),
            ],
          )),
    );
  }
}
