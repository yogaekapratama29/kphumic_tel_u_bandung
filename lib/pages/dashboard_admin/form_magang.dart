import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/admin_dashboard.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/profile_admin.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/tambah_form_magang.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class FormMagang extends StatefulWidget {
  const FormMagang({super.key});

  @override
  State<FormMagang> createState() => _FormMagangState();
}

  class _FormMagangState extends State<FormMagang> {
  final List<Map<String, dynamic>> posisi = [
    {
      "name": "Frontend",
      "description": "Membuat Tampilan Website",
      "status": "Dibuka",
      "color": "green",
      "endDate": DateTime(2024, 12, 31)
    },
    {
      "name": "Backend",
      "description": "Implementasi logic di Server",
      "status": "Ditutup",
      "color": "red",
      "endDate": DateTime(2023, 10, 20)
    },
    {
      "name": "Mobile",
      "description": "Membuat mobile aplikasi",
      "status": "Dibuka",
      "color": "green",
      "endDate": DateTime(2024, 11, 30)
    },
    {
      "name": "UI/UX",
      "description": "Mendesain Design interface",
      "status": "Dibuka",
      "color": "green",
      "endDate": DateTime(2024, 12, 10)
    },
  ];

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  // Fungsi untuk memeriksa tanggal dan memperbarui status
  void _checkStatus() {
    DateTime now = DateTime.now();
    setState(() {
      for (var item in posisi) {
        if (item['endDate'].isBefore(now)) {
          item['status'] = "Ditutup";
          item['color'] = "red";
        } else {
          item['status'] = "Dibuka";
          item['color'] = "green";
        }
      }
    });
  }

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
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileAdmin()),
        );
        break;
    }
  }

  
  Future<void> _navigateToTambahFormMagang() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahFormMagang()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        posisi.add(result);
      });
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
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.badge_outlined),
          GButton(icon: Icons.person_outline),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text("Form Magang", style: AppFonts.display2.primary),
              SizedBox(height: 50),
              Center(
                child: Container(
                  width: 328,
                  height: 31,
                  color: AppColors.primary,
                  child: Text(
                    "Form Magang",
                    style: AppFonts.body2.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: 31,
                width: 328,
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Posisi", style: AppFonts.small.white),
                    Text("Status Magang", style: AppFonts.small.white),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: posisi.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posisi[index]["name"] ?? "",
                          style: AppFonts.body2,
                        ),
                        SizedBox(height: 5),
                        Text(
                          posisi[index]["description"] ?? "",
                          style: AppFonts.body,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Periode: ${DateFormat('dd/MM/yyyy').format(posisi[index]['endDate'])}",
                              style: AppFonts.small,
                            ),
                            Container(
                              width: 96,
                              height: 27,
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                color: _getColorStatus(posisi[index]["color"]),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                posisi[index]["status"] ?? "",
                                style: AppFonts.body2.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  _navigateToTambahFormMagang(); 
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Tambah Form Magang",
                        style: AppFonts.body.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorStatus(String? color) {
    switch (color) {
      case "green":
        return Colors.green;
      case "red":
        return AppColors.primary;
      default:
        return Colors.transparent;
    }
  }
}

