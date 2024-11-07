import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';

class TambahFormMagang extends StatefulWidget {
  @override
  _TambahFormMagangState createState() => _TambahFormMagangState();
}

class _TambahFormMagangState extends State<TambahFormMagang> {
  String? _selectedBatch;
  List<Map<String, dynamic>> _batchList = [];
  TextEditingController _namaPosisiController = TextEditingController();
  TextEditingController _deskripsiPosisiController = TextEditingController();
  TextEditingController _keahlianController = TextEditingController();
  TextEditingController _slugController = TextEditingController();
  File? _roleImage;

  @override
  void initState() {
    super.initState();
    fetchBatches();
    if (_batchList.isNotEmpty) {
      _selectedBatch = _batchList.first['id'].toString();
    }
  }

  Future<void> fetchBatches() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    final url = Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> batches = data['data'];

      setState(() {
        _batchList = batches
            .map((batch) => {
                  'id': batch['id'],
                  'name': "Batch ${batch['number']}",
                })
            .toList();
      });
    } else {
      print("Failed to load batches: ${response.statusCode}");
    }
  }

  Future<void> _pickImage(String type) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (type == 'role') {
          _roleImage = File(result.files.single.path!);
        } else {
          // handle profile image if needed
        }
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_selectedBatch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a batch first."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    final url = Uri.parse(
        "https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp");
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = "Bearer $token";

    debugPrint("Preparing to send with the following values:");
    debugPrint("Slug: ${_slugController.text}");
    debugPrint("Name: ${_namaPosisiController.text}");
    debugPrint("Description: ${_deskripsiPosisiController.text}");
    debugPrint("Qualifications: ${_keahlianController.text}");
    debugPrint("Batch ID: $_selectedBatch");
    debugPrint("Role Image: $_roleImage");

    request.fields['slug'] = _slugController.text;
    request.fields['name'] = _namaPosisiController.text;
    request.fields['description'] = _deskripsiPosisiController.text;
    request.fields['kualifikasi'] = _keahlianController.text;
    request.fields['batch_id'] = _selectedBatch!;

    if (_roleImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('role_image', _roleImage!.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        _showSuccessDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Failed to save data. Error: ${responseData["message"]}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Form Magang 2', style: AppFonts.body),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            _roleImage != null ? FileImage(_roleImage!) : null,
                        child: _roleImage == null
                            ? Icon(Icons.person, size: 60)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () => _pickImage('role'),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primary,
                            child: Icon(Icons.camera_alt_outlined,
                                size: 20, color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text("Slug", style: AppFonts.body),
                SizedBox(height: 10),
                TextFormField(
                  controller: _slugController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text("Posisi", style: AppFonts.body),
                SizedBox(height: 10),
                TextFormField(
                  controller: _namaPosisiController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text("Deskripsi", style: AppFonts.body),
                SizedBox(height: 10),
                TextFormField(
                  controller: _deskripsiPosisiController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text("Keahlian", style: AppFonts.body),
                SizedBox(height: 10),
                TextFormField(
                  controller: _keahlianController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text("Batch Magang", style: AppFonts.body),
                SizedBox(height: 10),
                if (_batchList.isNotEmpty)
                  DropdownButtonFormField<String>(
                    value: _selectedBatch,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: _batchList.map((batch) {
                      return DropdownMenuItem<String>(
                        value: batch['id'].toString(),
                        child: Text(batch['name']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      debugPrint("Selected Batch ID: $newValue");
                      setState(() {
                        _selectedBatch = newValue;
                      });
                    },
                  )
                else
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grayColor,
                        fixedSize: Size(100, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Batal", style: AppFonts.body),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        fixedSize: Size(100, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: _updateProfile,
                      child: Text("Simpan", style: AppFonts.body),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Data saved successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}