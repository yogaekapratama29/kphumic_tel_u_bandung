import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class Profile extends StatelessWidget {
  final List<Color> _colors = [
    AppColors.secondary, // index 0
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
  ];
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
          iconSize: 30,
          activeColor: _colors[1],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PenerimaanMagang()));
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OurContact()));
                break;
              case 4:
                break;
            }
          },
          tabs: [
            GButton(icon: Icons.home_outlined),
            GButton(
              icon: Icons.info_outline,
              iconActiveColor: AppColors.primary,
            ),
            GButton(icon: Icons.badge_outlined),
            GButton(icon: Icons.call_outlined),
            GButton(icon: Icons.person_outline),
          ]),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      width: 325,
                      height: 632,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90,
                          ),
                          TextRow(
                              label: "Nama Lengkap : ",
                              value: "Mahasiswa Magang"),
                          SizedBox(height: 50),
                          TextRow(label: "NIM :", value: "3859263857"),
                          SizedBox(height: 50),
                          TextRow(label: "Prodi :", value: "Informatika"),
                          SizedBox(height: 50),
                          TextRow(
                              label: "Nomor Handphone :",
                              value: "0385716349481"),
                          SizedBox(height: 50),
                          TextRow(
                              label: "Email : ",
                              value: "mahasiswamagang\n243@gmail.com"),
                          SizedBox(height: 50),
                          TextRow(label: "CV :", value: "-"),
                          SizedBox(height: 50),
                          TextRow(label: "Portofolio :", value: "-"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 161, 167, 196)),
                        child: Image.asset("assets/Avatar.png")),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 102,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.accent),
                  child: Text(
                    "Edit",
                    textAlign: TextAlign.center,style: AppFonts.buttonText.white,
                  ),
                ),
                 Container(
                  alignment: Alignment.center,
                  width: 102,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.accent),
                  child: Text(
                    "Log Out",
                    textAlign: TextAlign.center,style: AppFonts.buttonText.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }
}

//Class
class TextRow extends StatelessWidget {
  final String label;
  final String value;

  const TextRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppFonts.body.white),
        Text(value, style: AppFonts.body.white),
      ],
    );
  }
}
