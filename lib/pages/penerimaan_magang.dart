import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/contents/content_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/magang_yang_dibuka/magang_1.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class PenerimaanMagang extends StatefulWidget {
  PenerimaanMagang({super.key});

  @override
  State<PenerimaanMagang> createState() => _PenerimaanMagangState();
}

class _PenerimaanMagangState extends State<PenerimaanMagang> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutUsPage()),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OurContact()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white,
      bottomNavigationBar: GNav(
        activeColor: AppColors.primary,
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        iconSize: 30,
        tabs: [
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.groups_2_outlined),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Konten 1
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Magang1()));
                          },
                          child: ContentMagang()),
                      SizedBox(height: 10,),
                      // Konten 2 
                       GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Magang1()));
                          },
                          child: ContentMagang()),
                      SizedBox(height: 10,),
                      // Konten 3
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Magang1()));
                          },
                          child: ContentMagang()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //

                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
