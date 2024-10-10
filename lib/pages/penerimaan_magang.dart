import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/contents/content_magang.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class PenerimaanMagang extends StatelessWidget {
  const PenerimaanMagang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Penerimaan",
                style: AppFonts.display2.primary,
              ),
            ),
            Center(
                child: Text(
              "Magang",
              style: AppFonts.display2.primary,
            )),
            SizedBox(
              height: 20,
            ),
           ContentMagang(),
          ],
        ),),
      ),
    );
  }
}
