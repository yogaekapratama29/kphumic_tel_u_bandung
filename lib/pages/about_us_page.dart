import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _currentIndex = 1;

  final List<Color> _colors = [
    AppColors.secondary, // index 0
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
    AppColors.secondary,
  ];

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                  break;
              }
            },
            tabs: [
              GButton(icon: Icons.home_outlined),
              GButton(icon: Icons.info_outline,iconActiveColor: AppColors.primary,),
              GButton(icon: Icons.badge_outlined),
              GButton(icon: Icons.call_outlined),
              GButton(icon: Icons.person_outline),
            ]),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "VISION & MISSION",
                    style: AppFonts.display2.primary,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Vision",
                    style: AppFonts.body.primary,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7, left: 3, right: 3),
                    width: 340,
                    height: 84,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "To become an excellent research center in the field of engineering to improve the human health and prosperity",
                      style: AppFonts.body.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 360,
                    height: 194,
                    child: Image.asset("assets/about_us.png"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Mission",
                    style: AppFonts.body.primary,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                    width: 350,
                    height: 450,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          "・Becoming the science and technology excellent center in the field of embedded sensor systems to support biomedical application based on the Internet of Things (IoT) ",
                          style: AppFonts.body.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "・Becoming the science and techonology excellent center on development remote health monitoring systems based on Internet of Things (IoT)",
                          style: AppFonts.body.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "・Becoming the science and technology excellent center on Big Data Analytic ",
                          style: AppFonts.body.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "・Becoming the science and techonology excellent center on health development of Information and Communication Technology (ICT) ",
                          style: AppFonts.body.white,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 360,
                    height: 267,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/quotes.png",
                          colorBlendMode: BlendMode.color,
                        ),
                        Container(
                          width: 360,
                          height: 267,
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bantinglah otak untuk mencari ilmu sebanyak-banyak guna mencari rahasia besar yang terkandung di dalam benda besar yang bernama dunia ini, tetapi pasanglah pelita dalam hati sanubari, yaitu pelita kehidupan jiwa.",
                              textAlign: TextAlign.center,
                              style: AppFonts.body.white,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                                width: 200,
                                child: Divider(
                                  color: AppColors.accent,
                                  height: 5,
                                  thickness: 1,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Al-Ghazali",
                              style: AppFonts.body.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Meet the People
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MEET THE",
                        style: AppFonts.caption.secondary,
                      ),
                      Text(
                        "Our People",
                        style: AppFonts.display2.primary,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Content
                  Column(
                    children: [
                      Container(
                        width: 190,
                        height: 190,
                        child: Image.asset("assets/people.png"),
                      ),
                      Container(
                        height: 128,
                        width: 190,
                        color: AppColors.accent,
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Satria Mandala, S.T, M.Sc, Ph.D.",
                              style: AppFonts.body.primary,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "DIRECTOR OF RESEARCH CENTER",
                              style: AppFonts.caption.primary,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 190,
                                  height: 23,
                                  color: AppColors.primary,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Image.asset(
                                        "assets/ig_vector.png",
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Image.asset(
                                        "assets/linkedin_vector.png",
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Image.asset(
                                        "assets/fb_vector.png",
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

