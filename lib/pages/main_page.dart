import 'dart:async';
import 'package:KP_HUMIC/contents/alur_magang.dart';
import 'package:KP_HUMIC/contents/main_page_contents.dart';
import 'package:KP_HUMIC/pages/about_us_page.dart';
import 'package:KP_HUMIC/pages/our_contact.dart';
import 'package:KP_HUMIC/pages/penerimaan_magang.dart';
import 'package:KP_HUMIC/pages/profile.dart';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _images = [
    "assets/content1.png",
    "assets/logoKPHumic.png",
    "assets/content1.png",
  ];

  late Stream<int> _autoSlideStream;

  @override
  void initState() {
    super.initState();

    // Timer Duration
    _autoSlideStream =
        Stream<int>.periodic(const Duration(seconds: 3), (index) {
      _currentIndex = (_currentIndex + 1) % _images.length;
      return _currentIndex;
    });

    // Stream untuk otomatis slide
    _autoSlideStream.listen((index) {
      if (mounted) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
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
      case 3 :
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OurContact()),
        );
        break;
       case 4 :
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(backgroundColor: AppColors.white,
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth < 360 ? 24 : 30;

          return GNav(
            activeColor: AppColors.primary,
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            iconSize: iconSize,
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.03,
              vertical: 25,
            ),
            tabs: [
              GButton(icon: Icons.home_outlined, iconSize: iconSize),
              GButton(icon: Icons.groups_2_outlined,  iconSize: iconSize),
              GButton(icon: Icons.badge_outlined, iconSize: iconSize),
              GButton(icon: Icons.call_outlined,  iconSize: iconSize),
              GButton(icon: Icons.person_outline,  iconSize: iconSize),
            ],
          );
        },
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    "WELCOME TO",
                    style: AppFonts.caption.secondary,
                  ),
                ),
                Text(
                  "HUMIC Engineering",
                  style: AppFonts.display2.primary,
                ),
                const SizedBox(height: 20),
                // Slider dan indikator
                _buildImageSlider(),
                const SizedBox(height: 40),
                Container(
                  width: 328,
                  child: Text(
                    "Humic Engineering dengan bangga membuka kesempatan magang bagi mahasiswa",
                    textAlign: TextAlign.center,
                    style: AppFonts.body,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 328,
                  child: Text(
                    "Jadilah bagian dari tim kami dan kembangkan karier Anda bersama HUMIC!",
                    textAlign: TextAlign.center,
                    style: AppFonts.body,
                  ),
                ),
                SizedBox(height: 70),
                Text(
                  "Alur Magang",
                  style: AppFonts.display2.primary,
                ),
                SizedBox(
                  height: 20,
                ),
                AlurMagang(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 188, // Tinggi konten slider yang diinginkan
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MainPageContents(image: _images[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Dot indicator
        SmoothPageIndicator(
          controller: _pageController,
          count: _images.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
