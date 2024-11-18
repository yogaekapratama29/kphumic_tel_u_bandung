import 'dart:convert';
import 'dart:io';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';


class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String _selectedGender = 'Laki-Laki';

  // Controllers
  final _namaController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _universityController = TextEditingController();
  final _nimController = TextEditingController();
  final _prodiController = TextEditingController();
  final _cvController = TextEditingController();
  final _portfolioController = TextEditingController();

  // File variables
  File? _profilePicture;
  File? _cvFile;
  File? _portfolioFile;

  Future<void> _pickProfilePicture() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _profilePicture = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      debugPrint("${result}");
      setState(() {
        _cvFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickPortfolioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _portfolioFile = File(result.files.single.path!);
      });
    }
  }

  // Function to send PUT request
  Future<void> _updateProfile() async {
    debugPrint(
        "${_namaController.text}\n ${_dobController.text} \n ${_selectedGender} \n ${_nimController.text} \n ${_universityController.text} \n ${_prodiController.text} \n ${_phoneController.text} \n ${_emailController.text} \n ${_profilePicture} \n ${_cvFile} \n ${_portfolioFile}");
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    final url = Uri.parse(
        "https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/user/me");
    final request = http.MultipartRequest('PUT', url);
    request.headers['Authorization'] = "Bearer $token";

    request.fields['full_name'] = _namaController.text;
    request.fields['birth_date'] = "${_dobController.text}Z";

    request.fields['gender'] = _selectedGender == "Laki-Laki" ? "M" : "F";
    request.fields['nim'] = _nimController.text;
    request.fields['perguruan_tinggi'] = _universityController.text;
    request.fields['prodi'] = _prodiController.text;
    request.fields['phone_number'] = _phoneController.text;
    request.fields['email'] = _emailController.text;

    // Add files if they exist
    if (_profilePicture != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', _profilePicture!.path));
    }
    if (_cvFile != null) {
      request.files.add(await http.MultipartFile.fromPath('cv', _cvFile!.path));
    }
    if (_portfolioFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('portfolio', _portfolioFile!.path));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        _showSuccessDialog(context);
      } else {
        final errorData = jsonDecode(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Failed to save data. Error: ${errorData["message"]}"),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 50,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 10),
                Text(
                  'Berhasil Disimpan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = pickedDate.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Edit Profile", style: AppFonts.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profilePicture != null
                          ? FileImage(_profilePicture!)
                          : null,
                      child: _profilePicture == null
                          ? Icon(Icons.person, size: 60)
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined,
                              size: 20, color: AppColors.white),
                          onPressed: _pickProfilePicture,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSection("Data Pribadi"),
              _buildTextField(
                  "Nama Lengkap", _namaController, "Mahasiswa Magang"),
              _buildGenderSelection(),
              _buildDateField("Tanggal Lahir", _dobController),
              _buildTextField("Email", _emailController, "mahasiswa@gmail.com"),
              _buildTextField(
                  "Nomor Handphone", _phoneController, "081435156462"),
              _buildSection("Data Perguruan Tinggi"),
              _buildTextField("Perguruan Tinggi", _universityController,
                  "Telkom University"),
              _buildTextField("NIM", _nimController, "1244668721"),
              _buildTextField("Prodi", _prodiController, "Informatika"),
              _buildSection("File Pendaftaran"),
              _buildFilePickerField("CV", _cvController, _pickCvFile),
              _buildFilePickerField(
                  "Portofolio", _portfolioController, _pickPortfolioFile),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_areFieldsValid()) {
                      _updateProfile(); // Call the update profile function
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Gagal menyimpan data. Pastikan semua data terisi"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text('Simpan', style: AppFonts.body.white),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title, style: AppFonts.title),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: "Pilih tanggal",
              filled: true,
              fillColor: AppColors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Radio(
          value: 'Laki-Laki',
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        Text('Laki-Laki'),
        Radio(
          value: 'Perempuan',
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        Text('Perempuan'),
      ],
    );
  }

  Widget _buildFilePickerField(
      String label, TextEditingController controller, Function onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: "Unggah $label",
              filled: true,
              fillColor: AppColors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              suffixIcon: Icon(Icons.upload_file),
            ),
          ),
        ),
      ),
    );
  }

  bool _areFieldsValid() {
    return _namaController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _universityController.text.isNotEmpty &&
        _nimController.text.isNotEmpty &&
        _prodiController.text.isNotEmpty;
  }
}
