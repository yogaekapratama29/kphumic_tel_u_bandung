import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/edit_profile/profile_form.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/started_page.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class Profile extends StatefulWidget {
  final String? namaLengkap;
  final String? nim;
  final String? prodi;
  final String? phone;
  final String? email;
  final String? cv;
  final String? portfolio;

  Profile({
    
    Key? key,
    this.namaLengkap = "Mahasiswa Magang",
    this.nim = "3859263857",
    this.prodi = "Informatika",
    this.phone = "0385716349481",
    this.email = "mahasiswamagang243@gmail.com",
    this.cv = "-",
    this.portfolio = "-",
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 4;

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
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OurContact()),
        );
        break;
      case 4:
       
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
              SizedBox(height: 50),
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Container(
                        width: 380,
                        height: 632,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 90),
                            TextRow(
                              label: "Nama Lengkap : ",
                              value: widget.namaLengkap!,
                            ),
                            SizedBox(height: 50),
                            TextRow(label: "NIM :", value: widget.nim!),
                            SizedBox(height: 50),
                            TextRow(label: "Prodi :", value: widget.prodi!),
                            SizedBox(height: 50),
                            TextRow(label: "Nomor Handphone :", value: widget.phone!),
                            SizedBox(height: 50),
                            TextRow(label: "Email :", value: widget.email!),
                            SizedBox(height: 50),
                            TextRow(label: "CV :", value: widget.cv!),
                            SizedBox(height: 50),
                            TextRow(label: "Portofolio :", value: widget.portfolio!),
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
                          color: Color.fromARGB(255, 161, 167, 196),
                        ),
                        child: Image.asset("assets/Avatar.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileForm(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 102,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.accent,
                      ),
                      child: Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: AppFonts.buttonText.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> StartedPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 102,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.accent,
                      ),
                      child: Text(
                        "Log Out",
                        textAlign: TextAlign.center,
                        style: AppFonts.buttonText.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// buat kelas agar lebih gampang panggil
class TextRow extends StatelessWidget {
  final String label;
  final String value;

  const TextRow({Key? key, required this.label, required this.value}) : super(key: key);

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
