import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/core/app_colors.dart';
import 'package:pharmacy_app/core/app_sizes.dart';



class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 190,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kTextColor2,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: kDefaultMargin * 3.2,
          child: Container(
            height: 160,
            width: 150,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius:
                    BorderRadius.circular(kDefaultRadius),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(3, 10),
                      blurRadius: 20,
                      color: kDarkColor.withOpacity(0.3)),
                ]),
            child: Center(
                child: SvgPicture.asset(
              "assets/images/icon-person.svg",
              height: 100,
              width: 110,
              fit: BoxFit.cover,
            )),
          ),
        ),
        Positioned(
          bottom: 45,
          left: kDefaultPadding *1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dr Larissa Meleuk",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kWhiteColor,
                ),
              ),
              Text("06 ans d'expérience",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kWhiteColor.withOpacity(0.5)
                ),
              ),
              const SizedBox(height: kDefaultMargin),
              Row(
                children: [
                  const Icon(CupertinoIcons.phone, color: kTextColor, size: 24),
                  const SizedBox(width: 5),
                  Text("+237 652 31 08 29",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kWhiteColor.withOpacity(0.8)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(CupertinoIcons.mail, color: kTextColor, size: 24),
                  const SizedBox(width: 5),
                  Text("larissameleuk@gmail.com",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kWhiteColor.withOpacity(0.8)
                    ),
                  ),
                ],
              ),                            
            ],
          ),
        ),
      ],
    );
  }
}