import 'dart:ffi';
import 'package:KP_HUMIC/pages/about_us_page.dart';
import 'package:KP_HUMIC/pages/edit_profile/profile_form.dart';
import 'package:KP_HUMIC/pages/main_page.dart';
import 'package:KP_HUMIC/pages/our_contact.dart';
import 'package:KP_HUMIC/pages/penerimaan_magang.dart';
import 'package:KP_HUMIC/pages/started_page.dart';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 4;
  String? namaLengkap;
  String? nim;
  String? prodi;
  String? phone;
  String? email;
  String? cv;
  String? portfolio;
  String? birthDate;
  String? gender;
  String? perguruanTinggi;
  String? profilePicture;
  String? applicationId;
  String? status;
  String? applicationDate;
  bool isLoading = true;
  String? errorMessage;

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Future<void> fetchUserData() async {
    debugPrint("Test Masuk");
    final storage = FlutterSecureStorage();
    try {
      String? token = await storage.read(key: "authToken");
      if (token == null) {
        setState(() {
          errorMessage = "No authentication token found.";
          isLoading = false;
        });
        return;
      }

      debugPrint("${token}");

      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/user/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['valid']) {
          setState(() {
            namaLengkap = data['data']['full_name'] ?? namaLengkap;
            nim = data['data']['nim'] ?? nim;
            prodi = data['data']['prodi'] ?? prodi;
            phone = data['data']['phone_number'] ?? phone;
            email = data['data']['email'] ?? email;
            cv = data['data']['cv'] ?? cv;
            portfolio = data['data']['portfolio'] ?? portfolio;
            birthDate = formatDate(data['data']['birth_date'] ?? '');
            gender = data['data']['gender'] ?? gender;
            perguruanTinggi =
                data['data']['perguruan_tinggi'] ?? perguruanTinggi;
            profilePicture = data['data']['profile_picture'] ?? profilePicture;
            applicationId = data['data']['kp_application']?['application_id'] ??
                "Belum Mendaftar";
            status =
                data['data']['kp_application']?['status'] ?? "Belum Mendaftar";
            applicationDate = formatDate(
                data['data']['kp_application']?['application_date'] ?? '');

            isLoading = false;
          });
          debugPrint("Masuk");
        } else {
          setState(() {
            errorMessage = "User data is invalid.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          final data = json.decode(response.body);
          errorMessage = "Server error: ${response.statusCode}";
          debugPrint("${data}");
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching user data: $e";
        isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUsPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PenerimaanMagang()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OurContact()));
        break;
      case 4:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
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
                                  height: 900,
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 40, right: 40),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(children: [
                                        Text(
                                          'Nama Lengkap: ',
                                          style: AppFonts.body.white,
                                        ),
                                        Spacer(),
                                        Text(
                                          '$namaLengkap',
                                          style: AppFonts.body.white,
                                        )
                                      ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'NIM: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text('$nim',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Prodi: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $prodi',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $phone',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Email: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text('$email',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('CV: $cv',
                                          style: AppFonts.body.white),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('Portfolio: $portfolio',
                                          style: AppFonts.body.white),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Tanggal Lahir: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text('$birthDate',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Gender: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $gender',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('Perguran Tinggi: $perguruanTinggi',
                                          style: AppFonts.body.white),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Application ID: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $applicationId',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Status : ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $status',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Application Date: ',
                                            style: AppFonts.body.white,
                                          ),
                                          Spacer(),
                                          Text(' $applicationDate',
                                              style: AppFonts.body.white),
                                        ],
                                      ),
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
                                  child: profilePicture != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            profilePicture!,
                                            fit: BoxFit.cover,
                                            width: 96,
                                            height: 96,
                                          ),
                                        )
                                      : Icon(Icons.person,
                                          size: 96, color: Colors.grey),
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
                              onTap: () async {
                                final storage = new FlutterSecureStorage();
                                await storage.delete(key: 'authToken');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StartedPage()));
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
