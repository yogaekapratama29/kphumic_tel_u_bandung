import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:flutter/material.dart';


class ContentMagang extends StatelessWidget {
  const ContentMagang({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            color: AppColors.accent.withOpacity(0.5),
            offset: Offset(0, 2),
            spreadRadius: 2,
            blurRadius: 7),
      ]),
      width: 309,
      height: 299,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 280,
              height: 138,
              decoration: BoxDecoration(),
              child: Image.asset("assets/gedungTelU.png"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Posisi Magang",
            style: AppFonts.small.primary,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
              "Lorem ipsum doloor sit aetir adi, consecture adipting elit. Quisque placecerat"),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Text(
              "Detail",
              style: AppFonts.body.secondary,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppColors.primary,
            )
          ])
        ],
      ),
    );
  }
}
