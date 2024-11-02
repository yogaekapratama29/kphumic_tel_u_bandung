import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/pages/profile.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

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

// Function success dialog
void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Icon(
                Icons.check_circle_outline,
                size: 50,
                color: Colors.blueAccent, 
              ),
              SizedBox(height: 10),

              // Success Message
              Text(
                'Berhasil Disimpan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),

              // OK Button
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Profile
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 60),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.camera_alt_outlined,
                            size: 20, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Data Pribadi
              Text("Data Pribadi", style: AppFonts.title),
              SizedBox(height: 10),

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: 400,
                  height: 500,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      Text(
                        "Nama Lengkap",
                        style: AppFonts.inter.white,
                      ),
                      buildTextField(
                          controller: _namaController,
                          hintText: 'Mahasiswa Magang'),
                      SizedBox(height: 10),

                      // Gender Selection
                      Text(
                        "Gender",
                        style: AppFonts.inter.white,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              title: Text(
                                'Laki-Laki',
                                style: AppFonts.inter,
                              ),
                              leading: Radio<String>(
                                activeColor: AppColors.white,
                                value: 'Laki-Laki',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              title: Text(
                                'Perempuan',
                                style: AppFonts.inter,
                              ),
                              leading: Radio<String>(
                                activeColor: AppColors.white,
                                value: 'Perempuan',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Tanggal Lahir
                      Text(
                        "Tanggal Lahir",
                        style: AppFonts.inter.white,
                      ),
                      buildTextField(
                          controller: _dobController, hintText: 'Input Text'),

                      // Email
                      Text(
                        "Email",
                        style: AppFonts.inter.white,
                      ),
                      buildTextField(
                          controller: _emailController,
                          hintText: 'mahasiswa2314@gmail.com'),

                      // Phone Number
                      Text(
                        "Nomor Handphone",
                        style: AppFonts.inter.white,
                      ),
                      buildTextField(
                          controller: _phoneController,
                          hintText: '081435156462'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text("Data Perguruan Tinggi", style: AppFonts.title),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: 400,
                height: 320,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // University
                    Text(
                      "Perguruan Tinggi",
                      style: AppFonts.inter.white,
                    ),
                    buildTextField(
                        controller: _universityController,
                        hintText: 'Telkom University'),

                    // NIM
                    Text(
                      "NIM",
                      style: AppFonts.inter.white,
                    ),
                    buildTextField(
                        controller: _nimController, hintText: '1244668721'),

                    // Program Studi
                    Text(
                      "Prodi",
                      style: AppFonts.inter.white,
                    ),
                    buildTextField(
                        controller: _prodiController, hintText: 'Informatika'),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text("File Pendaftaran", style: AppFonts.title),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: 400,
                height: 230,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CV Link
                    Text(
                      "CV",
                      style: AppFonts.inter.white,
                    ),
                    buildTextField(
                        controller: _cvController, hintText: 'Input link'),
                    Text(
                      "Portofolio",
                      style: AppFonts.inter.white,
                    ),
                    // Portfolio Link
                    buildTextField(
                        controller: _portfolioController,
                        hintText: 'Input link'),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Collect data
                      String updatedName = _namaController.text;
                      String updatedNim = _nimController.text;
                      String updatedProdi = _prodiController.text;
                      String updatedPhone = _phoneController.text;
                      String updatedEmail = _emailController.text;
                      String updatedCv = _cvController.text;
                      String updatedPortfolio = _portfolioController.text;
                      // cek jika null
                      if (updatedName.isEmpty ||
                          updatedNim.isEmpty ||
                          updatedProdi.isEmpty ||
                          updatedPhone.isEmpty ||
                          updatedEmail.isEmpty ||
                          updatedCv.isEmpty ||
                          updatedPortfolio.isEmpty) {
                       // snackbar jika gagal
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Gagal menyimpan data. Pastikan semua data terisi"),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      } else {
                        // snackbar jika berhasil
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Data berhasil disimpan."),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // tampilkan method show succes dialog
                        _showSuccessDialog(context);

                        // Proses simpan data dan navigasi
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              namaLengkap: updatedName,
                              nim: updatedNim,
                              prodi: updatedProdi,
                              phone: updatedPhone,
                              email: updatedEmail,
                              cv: updatedCv,
                              portfolio: updatedPortfolio,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                    child: Text(
                      'Simpan',
                      style: AppFonts.body.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk TextField
  Widget buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}


