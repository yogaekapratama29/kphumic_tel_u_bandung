import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/contents/content_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class PenerimaanMagang extends StatelessWidget {
    final List<Color> _colors = [
    AppColors.secondary, // index 0
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
  ];
   PenerimaanMagang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: GNav(
        iconSize: 30,
        activeColor: _colors[3],
        onTabChange: (index) {
          switch (index) {
            case 0:
                          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()));
              break;
            case 2:

              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OurContact()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile()));
              break;
          }
        },
        tabs: [
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.info_outline),
          GButton(icon: Icons.badge_outlined),
          GButton(icon: Icons.call_outlined),
          GButton(icon: Icons.person_outline),
        ],
      ),
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContentMagang(),
                      ContentMagang(),
                    ],
                  ),SizedBox(height: 20,),
                  //
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContentMagang(),
                      ContentMagang(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContentMagang(),
                      ContentMagang(),
                    ],
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
