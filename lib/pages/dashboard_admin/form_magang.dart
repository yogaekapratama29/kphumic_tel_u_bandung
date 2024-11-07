import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/admin_dashboard.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/batch_magang.dart';
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
  List<Map<String, dynamic>> posisi = [];
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          posisi = (data['data'] as List).map((role) {
            DateTime? endDate;
            if (role['batch']['closed_at'] != null) {
              endDate = DateTime.parse(role['batch']['closed_at']);
            }

            return {
              "role_id": role['role_id'],
              "name": role['name'] ?? "Unknown",
              "status": (endDate != null && endDate.isAfter(DateTime.now())) ? "Dibuka" : "Ditutup",
              "color": (endDate != null && endDate.isAfter(DateTime.now())) ? "green" : "red",
              "endDate": endDate ?? DateTime.now()
            };
          }).toList();
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _deletePosition(int id) async {
    debugPrint("${id}");
    try {
      final storage = FlutterSecureStorage();
      String? token = await storage.read(key: "authToken");
      final response = await http.delete(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          posisi.removeWhere((position) => position["role_id"] == id);
        });
        print('Position deleted successfully');
      } else {
        print('Failed to delete position');
      }
    } catch (e) {
      print('Error: $e');
    }
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BatchMagang()),
        );
        break;
      case 2:
        break;
      case 3:
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
      backgroundColor: AppColors.white,
      bottomNavigationBar: GNav(
        activeColor: AppColors.primary,
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        iconSize: 30,
        tabs: [
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.date_range_outlined),
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
                  width: MediaQuery.of(context).size.width * 0.9,
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 31,
                width: MediaQuery.of(context).size.width * 0.9,
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
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posisi[index]["name"] ?? "",
                                style: AppFonts.body2,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Periode: ${DateFormat('dd/MM/yyyy').format(posisi[index]['endDate'] ?? DateTime.now())}",
                                style: AppFonts.small,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
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
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deletePosition(posisi[index]["role_id"]),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TambahFormMagang()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
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
