import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/admin_dashboard.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/batch_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/form_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/pages/started_page.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
int _selectedIndex = 3; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

   switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BatchMagang()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormMagang()),
        );
        break;
      case 3:
      
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
          GButton(icon: Icons.home_outlined, ),
           GButton(
            icon: Icons.date_range_outlined,
          ),
          GButton(icon: Icons.badge_outlined,),
          GButton(icon: Icons.person_outline,),
        ],
      ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                    height: 192,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        TextRowAdmin(label: "Nama : ", value: "Admin 1"),
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
          GestureDetector(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> StartedPage()));
          },
            child: Padding(
              padding: EdgeInsets.only(right: 40),
              child: Align(alignment: Alignment.bottomRight,
                child: Container(
                  alignment: Alignment.center,
                  width: 132,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.accent),
                  child: Text(
                    "Log Out",
                    textAlign: TextAlign.center,
                    style: AppFonts.buttonText.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}

//Class TextRow
class TextRowAdmin extends StatelessWidget {
  final String label;
  final String value;

  const TextRowAdmin({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.body.white),
        Text(value, style: AppFonts.body.white),
      ],
    );
  }
}
