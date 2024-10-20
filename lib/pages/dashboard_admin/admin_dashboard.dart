import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/form_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/profile_admin.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/penerimaan_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Map<String, String>> students = [
    {"name": "Mahasiswa A", "status": "Lulus", "color": "green"},
    {"name": "Mahasiswa B", "status": "Gagal", "color": "red"},
    {"name": "Mahasiswa C", "status": "Proses", "color": "grey"},
    {"name": "Mahasiswa D", "status": "Non", "color": "black"},
  ];

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
          MaterialPageRoute(builder: (context) => FormMagang()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileAdmin()),
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: GNav(
        activeColor: AppColors.primary,
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        iconSize: 30,
        tabs: [
          GButton(icon: Icons.home_outlined, ),
          GButton(icon: Icons.badge_outlined,),
          GButton(icon: Icons.person_outline,),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Dashboard",
                style: AppFonts.display2.primary,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 328,
                  height: 131,
                  color: Color.fromARGB(255, 255, 255, 174),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Jumlah Pengguna",
                        style: AppFonts.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "4",
                        style: AppFonts.display2,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 328,
                  height: 131,
                  color: Color.fromARGB(255, 193, 255, 178),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Jumlah Pengguna",
                        style: AppFonts.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "4",
                        style: AppFonts.display2,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 328,
                  height: 31,
                  color: AppColors.primary,
                  child: Text(
                    "Pengguna Aktif",
                    style: AppFonts.body2.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 31,
                width: 328,
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: AppFonts.small.white,
                    ),
                    Text(
                      "Status Penerimaan",
                      style: AppFonts.small.white,
                    )
                  ],
                ),
              ),
              // Tabel Pengguna Aktif
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        students[index]["name"] ?? "",
                        style: AppFonts.body2,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 96,
                            height: 27,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            decoration: BoxDecoration(
                              color: _getColor(students[index]["color"]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              students[index]["status"] ?? "",
                              style: AppFonts.body2.white,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, color: AppColors.primary),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Fungsi untuk mendapatkan warna berdasarkan status
Color _getColor(String? color) {
  switch (color) {
    case "green":
      return Colors.green;
    case "red":
      return AppColors.primary;
    case "grey":
      return Colors.grey;
    case "black":
      return Colors.black;
    default:
      return Colors.transparent;
  }
}
