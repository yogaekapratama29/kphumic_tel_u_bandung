import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class TambahFormMagang extends StatefulWidget {
  @override
  _TambahFormMagangState createState() => _TambahFormMagangState();
}

class _TambahFormMagangState extends State<TambahFormMagang> {
  String? _selectedBatch;
  List<Map<String, dynamic>> _batchList = [];
  bool _isLoading = true;  
  TextEditingController _namaPosisiController = TextEditingController();
  TextEditingController _deskripsiPosisiController = TextEditingController();
  TextEditingController _keahlianController = TextEditingController();
 
  File? _roleImage;

@override
void initState() {
  super.initState();
  _selectedBatch = null;
  fetchBatches();
}

 Future<void> fetchBatches() async {
  setState(() {
    _isLoading = true;
    _batchList = []; // Reset list
  });

  try {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    final url = Uri.parse('https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> batches = data['data'];

      if (batches.isNotEmpty) {
        setState(() {
          _batchList = batches
              .map((batch) => {
                    'id': batch['batch_id'].toString(),
                    'name': "Batch ${batch['number']}",
                  })
              .toList();
          // Set nilai default untuk selected batch
          _selectedBatch = _batchList[0]['id'].toString();
        });
      }
    } else {
      throw Exception("Failed to load batches: ${response.statusCode}");
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to load batches: $e"),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
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
        }
      });
    }
  }

  bool _validateForm() {
    if (_selectedBatch == null || _selectedBatch!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a batch"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (_namaPosisiController.text.isEmpty ||
        _deskripsiPosisiController.text.isEmpty ||
        _keahlianController.text.isEmpty 
       ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> _tambahPosisiMagang() async {
    if (!_validateForm()) {
      return;
    }

    try {
      final storage = FlutterSecureStorage();
      String? token = await storage.read(key: "authToken");
      final url = Uri.parse(
          "https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/role-kp");
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = "Bearer $token";

      
      request.fields['name'] = _namaPosisiController.text;
      request.fields['description'] = _deskripsiPosisiController.text;
      request.fields['kualifikasi'] = _keahlianController.text;
      request.fields['batch_id'] = _selectedBatch!;

      if (_roleImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('role_image', _roleImage!.path));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      
      if (response.statusCode == 201) {
        _showSuccessDialog(context);
      } else {
        throw Exception(responseData["message"]);
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
        backgroundColor: AppColors.white
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      Text("Posisi", style: AppFonts.body),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _namaPosisiController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter position',
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
                          hintText: 'Enter description',
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
                          hintText: 'Enter required skills',
                        ),
                      ),
                      SizedBox(height: 16),
                     if (_isLoading)
  Center(child: CircularProgressIndicator())
else if (_batchList.isEmpty)
  // Jika list kosong, tampilkan field disabled
  TextFormField(
    enabled: false,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'No batches available',
    ),
  )
else
  DropdownButtonFormField<String>(
    value: _selectedBatch ?? _batchList[0]['id'].toString(),
    isExpanded: true,
    hint: Text('Select batch'),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: _batchList.map<DropdownMenuItem<String>>((Map<String, dynamic> batch) {
      return DropdownMenuItem<String>(
        value: batch['id'].toString(),
        child: Text(batch['name'] ?? ''),
      );
    }).toList(),
    onChanged: (String? newValue) {
      if (newValue != null) {
        setState(() {
          _selectedBatch = newValue;
        });
      }
    },
  ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.grayColor,
                              fixedSize: Size(130, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Batal", style: AppFonts.body.white),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              fixedSize: Size(130, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: _tambahPosisiMagang,
                            child: Text("Simpan", style: AppFonts.body.white),
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
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to previous screen
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}