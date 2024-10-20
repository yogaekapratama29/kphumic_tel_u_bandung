import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class Magang1 extends StatelessWidget {
  const Magang1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PenerimaanMagang()));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 27,
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Penerimaan\nMagang",
            style: AppFonts.display2.primary,
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 144,
            width: 144,
            child: Image.asset("assets/magang.png"),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Web Developer",
            style: AppFonts.title.primary,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              width: 328,
              child: Column(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque placerat scelerisque tortor ornare ornare. Quisque placerat scelerisque tortor ornare ornare Convallis felis vitae tortor augue. Velit nascetur proin massa in. Consequat faucibus porttitor enim et.",
                    style: AppFonts.body,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet: consectetur adipiscing elit.",
                    style: AppFonts.body.black,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 119,
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Daftar",
                      style: AppFonts.body.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
