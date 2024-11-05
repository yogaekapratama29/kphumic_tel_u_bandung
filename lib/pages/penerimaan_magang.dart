import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kphumic_tel_u_bandung/pages/about_us_page.dart';
import 'package:kphumic_tel_u_bandung/pages/magang_yang_dibuka/magang_1.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/our_contact.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PenerimaanMagang extends StatefulWidget {
  PenerimaanMagang({super.key});

  @override
  State<PenerimaanMagang> createState() => _PenerimaanMagangState();
}

class _PenerimaanMagangState extends State<PenerimaanMagang> {
  int _selectedIndex = 2;
  List<Map<String, dynamic>> internships = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchDataPosisiMagang() async {
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

  @override
  void initState() {
    super.initState();
    fetchDataPosisiMagang();
  }

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
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OurContact()),
        );
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
          GButton(icon: Icons.groups_2_outlined),
          GButton(icon: Icons.badge_outlined),
          GButton(icon: Icons.call_outlined),
          GButton(icon: Icons.person_outline),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage != null
                  ? Center(child: Text(errorMessage!))
                  : Column(
                      children: [
                        SizedBox(height: 30),
                        Center(
                          child: Text(
                            "Penerimaan",
                            style: AppFonts.display2.primary,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Magang",
                            style: AppFonts.display2.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: internships.map((internship) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0,left: 15,right: 15), // Adds a gap between items
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Magang1()),
                                  );
                                },
                                child: ContentMagang(
                                  name: internship['name'],
                                  description: internship['description'],
                                  roleImage: internship['role_image'],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ContentMagang extends StatelessWidget {
  final String? name;
  final String? description;
  final String? roleImage;

  const ContentMagang({this.name, this.description, this.roleImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (roleImage != null)
            Image.network(
              roleImage!,
              height: 100,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          SizedBox(height: 20),
          Text(
            name ?? 'Default Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            description ?? 'Default description for the role.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
