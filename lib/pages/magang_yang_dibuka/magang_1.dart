import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class Magang1 extends StatefulWidget {
  final String posisiId;

  const Magang1({Key? key, required this.posisiId}) : super(key: key);

  @override
  State<Magang1> createState() => _Magang1State();
}

class _Magang1State extends State<Magang1> {
  Map<String, dynamic>? applicantData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApplicantData();
  }

  Future<void> fetchApplicantData() async {
  final storage = FlutterSecureStorage();
  String? token = await storage.read(key: "authToken");

  // Periksa apakah token ada
  if (token == null) {
    print('Token is missing.');
    setState(() {
      isLoading = false;
    });
    return;
  }

  try {
    final response = await http.get(
      Uri.parse(
          'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp/${widget.posisiId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        // Parse JSON hanya jika statusCode adalah 200
        setState(() {
          applicantData = json.decode(response.body)['data'];
          isLoading = false;
        });
      } catch (e) {
        print('Error parsing JSON: $e');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Tampilkan status code dan respons jika gagal
      print('Failed to load data: ${response.statusCode}');
      print('Response body: ${response.body}');
      setState(() {
        isLoading = false;
      });
    }
  } catch (error) {
    // Tangani error jaringan
    print('An error occurred: $error');
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        applicantData?['name'] ?? 'Job Position',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        applicantData?['role_image'] ??
                            'https://via.placeholder.com/150',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      Text(
                        applicantData?['description'] ??
                            'Job description goes here...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Kualifikasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        applicantData?['kualifikasi'] ??
                            'Job qualifications go here...',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          final roleId = applicantData?['role_id'];
                          final storage = FlutterSecureStorage();
                          try {
                            String? token =
                                await storage.read(key: "authToken");
                            debugPrint("Token: $token");
                            debugPrint("roleId type: ${roleId.runtimeType}");
                            debugPrint(roleId.toString());

                            if (token != null) {
                              final response = await http.post(
                                Uri.parse(
                                    'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp'),
                                headers: {
                                  "Authorization": "Bearer $token",
                                  "Content-Type": "application/json"
                                },
                                body: jsonEncode({"roleId" : roleId.toString()}),
                              );

                              final responseData = json.decode(response.body);
                              debugPrint(
                                  "Response message: ${responseData['message']}");

                              if (response.statusCode == 201) {
                                debugPrint(
                                    "Application submitted successfully.");
                                // You may want to show a success dialog or navigate away
                              } else {
                                debugPrint("Error: ${responseData['message']}");
                                // Handle other status codes, like showing an error message
                              }
                            } else {
                              debugPrint("No token found");
                              // Handle case where token is missing, such as showing a login prompt
                            }
                          } catch (error) {
                            debugPrint("An error occurred: $error");
                            // Handle network errors, like showing an error dialog
                          }
                        },
                        child: Text('Daftar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
