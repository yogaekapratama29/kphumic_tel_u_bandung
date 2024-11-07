import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class ProsesPelamar extends StatefulWidget {
  final String applicationId;

  const ProsesPelamar({Key? key, required this.applicationId}) : super(key: key);

  @override
  State<ProsesPelamar> createState() => _ProsesPelamarState();
}

class _ProsesPelamarState extends State<ProsesPelamar> {
  String? _selectedValue;
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
    final response = await http.get(
      Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp/${widget.applicationId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        applicantData = json.decode(response.body)['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load data');
    }
  }

  Future<void> updateApplicationStatus() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");

    final response = await http.put(
      Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp/${widget.applicationId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'status': _selectedValue,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("Status updated successfully");
      fetchApplicantData(); // Optionally refresh data
    } else {
      debugPrint("Failed to update status: ${response.body}");
    }
  }

  Future<void> deleteApplication() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");

    final response = await http.delete(
      Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/application-kp/${widget.applicationId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint("Application successfully deleted");
      Navigator.pop(context); // Optionally navigate back after deletion
    } else {
      debugPrint("Failed to delete application: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person, size: 60),
                        ),
                      ),
                      SizedBox(height: 50),
                      buildInfoField("Nama Lengkap", applicantData?['user']['full_name'] ?? "-"),
                      buildInfoField("Gender", applicantData?['user']['gender'] ?? "-"),
                      buildInfoField("Tanggal Lahir", applicantData?['user']['dob'] ?? "-"),
                      buildInfoField("Email", applicantData?['user']['email'] ?? "-"),
                      buildInfoField("Nomor Handphone", applicantData?['user']['phone_number'].toString() ?? "-"),
                      buildInfoField("Perguruan Tinggi", applicantData?['user']['perguruan_tinggi'] ?? "-"),
                      buildInfoField("NIM", applicantData?['user']['nim'].toString() ?? "-"),
                      buildInfoField("Prodi", applicantData?['user']['prodi'] ?? "-"),
                      buildInfoField("CV", applicantData?['user']['cv'] ?? "-"),
                      buildInfoField("Portofolio", applicantData?['user']['portfolio'] ?? "-"),
                      buildInfoField("Posisi", applicantData?['kp_role']['name'] ?? "-"),
                      Text("Status Penerimaan", style: AppFonts.body),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedValue ?? applicantData?['status'] ?? 'Proses',
                        items: <String>['Proses', 'Lulus', 'Gagal'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton("Batal", AppColors.accent, () {}),
                          buildButton("Simpan", AppColors.accent, updateApplicationStatus),
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: buildButton("Hapus", AppColors.primary, deleteApplication),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.body),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          height: 48,
          width: 328,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: AppFonts.body,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 129,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: AppFonts.body.white,
        ),
      ),
    );
  }
}
