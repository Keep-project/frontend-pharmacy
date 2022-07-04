

import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';

class CustomSnacbar{
  static showMessage(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.fixed,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 100,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kTextColor2,
                  borderRadius: BorderRadius.circular(kDefaultRadius*1.2)
                ),
                child:  Column(
                  children: [
                    const Spacer(),
                    Text(message,
                    style: const TextStyle(
                      fontStyle: FontStyle.normal,
                    )),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 20,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: kOrangeColor,
                    borderRadius: BorderRadius.circular(kDefaultRadius*4),
                  ),
                  child: const Center(
                    child: Icon(Icons.close, size: 26, color: kWhiteColor),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}