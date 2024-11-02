import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class OurContact extends StatefulWidget {
  OurContact({super.key});

  @override
  State<OurContact> createState() => _OurContactState();
}

class _OurContactState extends State<OurContact> {
  int _selectedIndex = 3;

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PenerimaanMagang()),
        );
        break;
      case 3:
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
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Location",
              style: AppFonts.display2.primary,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.primary,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 4.0)),
              alignment: Alignment.center,
              width: 328,
              height: 206,
              child: Image.asset(
                "assets/Map.png",
                width: 328,
                height: 206,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "GET IN TOUCH",
              style: AppFonts.caption.secondary,
            ),
            Text(
              "Contact",
              style: AppFonts.display2.primary,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Box Pertama
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 170,
                  height: 170,
                  padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phone_in_talk,
                            color: AppColors.primary,
                            size: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Layanan\nKeluhan",
                            style: AppFonts.body2.primary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "https://bit.ly/Layanan_Keluhan_RCHUMIC ",
                        style: AppFonts.small.underline.primary,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                // Box Kedua
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5)),
                  width: 170,
                  height: 170,
                  padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Location",
                            style: AppFonts.body2.white,
                          )
                        ],
                      ),
                      Text(
                        "Telkom University Gedung F-IF3.01.08",
                        style: AppFonts.body.white,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Box ketiga
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5)),
                  width: 170,
                  height: 170,
                  padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.mail_outline,
                            color: AppColors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Email",
                            style: AppFonts.body2.white,
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "humic@telkomuniversity.ac.id",
                        style: AppFonts.body.underline.white,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                // Box Keempat
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 170,
                  height: 170,
                  padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.access_time,
                            color: AppColors.primary,
                            size: 39,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Working \nHours",
                            style: AppFonts.body2.primary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Senin - Jumat",
                        style: AppFonts.body.primary,
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        "09.00 - 18.00",
                        style: AppFonts.body.primary,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 308,
              height: 290,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.primary,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 5)),
              child: Image.asset("assets/qr.png"),
            ),
            SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );
  }
}
