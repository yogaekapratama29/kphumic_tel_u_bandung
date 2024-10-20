import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class ContentMagang extends StatelessWidget {
  const ContentMagang({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: 120,
              height: 233,
              color: AppColors.white,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 96,
                    height: 96,
                    child: Image.asset("assets/magang.png"),
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
                  Text("Lorem ipsum doloor sit aetir adi"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Text(
                      "Detail",
                      style: AppFonts.body.secondary,
                    ),SizedBox(width: 3,),
                    Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.primary,)
                  ])
                ],
              ),
            );
  }
}