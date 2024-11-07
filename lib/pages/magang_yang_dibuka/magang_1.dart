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
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('An error occurred: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> submitApplication() async {
    final roleId = applicantData?['role_id'];
    if (roleId == null) {
      print("Error: roleId is null.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Role ID is missing, cannot submit application."),
        ),
      );
      return;
    }

    final storage = FlutterSecureStorage();
    try {
      String? token = await storage.read(key: "authToken");
      debugPrint("Token: $token");

      if (token != null) {
        final response = await http.post(
          Uri.parse(
              'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp'),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"roleId": roleId}),
        );

        final responseData = json.decode(response.body);
        debugPrint("Response message: ${responseData['message']}");

        if (response.statusCode == 201) {
          debugPrint("Application submitted successfully.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Application submitted successfully.")),
          );
        } else {
          debugPrint("Error: ${responseData['message']}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${responseData['message']}")),
          );
        }
      } else {
        debugPrint("No token found");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Authentication token is missing.")),
        );
      }
    } catch (error) {
      debugPrint("An error occurred: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred, please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Text("Penerimaan\nMagang",style: AppFonts.display2.primary,textAlign: TextAlign.center,),
                        SizedBox(height: 20),
                        Container(
                          width: 324,
                          height: 144,
                          child: Image.network(
                            applicantData?['role_image'] ??
                                'https://via.placeholder.com/150',
                           
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          applicantData?['name'] ?? 'Job Position',
                          style: AppFonts.title.primary,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          applicantData?['description'] ??
                              'Job description goes here...',
                          style: AppFonts.body.black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Kualifikasi',
                          style: AppFonts.body.black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          applicantData?['kualifikasi'] ??
                              'Job qualifications go here...',
                          style: AppFonts.body.black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: submitApplication,
                          child: Text(
                            'Daftar',
                            style: AppFonts.body2.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
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
            ),
    );
  }
}
