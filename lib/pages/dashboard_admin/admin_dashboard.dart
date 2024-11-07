import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/batch_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/form_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/profile_admin.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/proses_pelamar.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page_admin.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Map<String, dynamic>> lamaran = [];

  @override
  void initState() {
    super.initState();
    _fetchLamaranData();
    _checkToken();
    _fetchDataPosisiMagang();
  }

  void _checkToken() async {
    final storage = FlutterSecureStorage();
    try {
      String? token = await storage.read(key: "authToken");
      if (token == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPageAdmin()));
      }
      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/verify-token'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode != 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPageAdmin()));
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
  }

  Future<void> _fetchLamaranData() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");

    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          lamaran = List<Map<String, dynamic>>.from(data['data']);
        });
      } else {
        debugPrint("Failed to load data");
      }
    } catch (error) {
      debugPrint("Error fetching data: $error");
    }
  }
/// 
  List<Map<String, dynamic>> internships = [];
  bool isLoading = true;
  String? errorMessage;

Future<void> _fetchDataPosisiMagang() async {
    debugPrint("Starting fetch data");

    try {
      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp'),
      );
      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Response data: $data");

        if (data['status'] == "Success") {
          setState(() {
            internships = List<Map<String, dynamic>>.from(data['data']);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = "User data is invalid.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Server error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
    }
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
            context, MaterialPageRoute(builder: (context) => BatchMagang()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormMagang()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileAdmin()));
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
              Text("Dashboard", style: AppFonts.display2.primary),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 328,
                height: 131,decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 174)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Jumlah Pelamar",style: AppFonts.title.black,), Text("${lamaran.length}",style: AppFonts.display2.black,)],
                ),
              ),SizedBox(height: 10,),

               Container(
                width: 328,
                height: 131,decoration: BoxDecoration(color: Color.fromARGB(255, 193, 255, 178)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Jumlah Posisi Magang",style: AppFonts.title.black), Text("${internships.length}",style: AppFonts.display2.black,)],
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  width: 328,
                  height: 31,
                  color: AppColors.primary,
                  child: Text("Pengguna Aktif",
                      style: AppFonts.body2.white, textAlign: TextAlign.center),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 31,
                width: 328,
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nama", style: AppFonts.small.white),
                    Text("Status", style: AppFonts.small.white),
                  ],
                ),
              ),
              // Display applications
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lamaran.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: () {
                   

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProsesPelamar(applicationId: lamaran[index]['application_id'].toString(),)));
                  },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          lamaran[index]["user"]['full_name'] ?? "Unknown",
                          style: AppFonts.body2,
                        ),
                        trailing: Container(
                          width: 96,
                          height: 27,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _getStatusColor(lamaran[index]["status"]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            lamaran[index]["status"] ?? "",
                            style: AppFonts.body2.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Proses":
        return Colors.grey;
      case "Lulus":
        return Colors.green;
      case "Gagal":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
