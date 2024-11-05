import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class Magang1 extends StatefulWidget {
  const Magang1({super.key});

  @override
  _Magang1State createState() => _Magang1State();
}

class _Magang1State extends State<Magang1> {
  Map<String, dynamic>? roleData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRoleData();
  }

  Future<void> fetchRoleData() async {
    try {
      final response = await http.get(
        Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp/2'),
      );
      debugPrint('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          roleData = json.decode(response.body)['data'];
          errorMessage = null;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data: Status Code ${response.statusCode}';
        });
        debugPrint('Response Body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
      });
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: errorMessage != null
            ? Center(child: Text(errorMessage!))
            : roleData == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Penerimaan\nMagang",
                            style: AppFonts.display2.primary,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          height: 144,
                          width: 324,
                          child: Image.network(
                            roleData!['role_image'] ?? '', // Gambar dari URL API
                            errorBuilder: (context, error, stackTrace) {
                              // Tampilkan gambar default jika terjadi error
                              return Image.asset("assets/gedungTelU.png");
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          roleData?['name'] ?? "Role Name",
                          style: AppFonts.title.primary,
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: 328,
                          child: Column(
                            children: [
                              Text(
                                roleData?['description'] ?? "Description not available.",
                                style: AppFonts.body,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Kualifikasi: ${roleData?['kualifikasi'] ?? 'Not available'}",
                                style: AppFonts.body.black,
                              ),
                              SizedBox(height: 30),
                              Container(
                                alignment: Alignment.center,
                                width: 119,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Daftar",
                                  style: AppFonts.body.white,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
