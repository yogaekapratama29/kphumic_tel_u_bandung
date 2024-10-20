import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class ProsesPelamar extends StatefulWidget {
  const ProsesPelamar({super.key});

  @override
  State<ProsesPelamar> createState() => _ProsesPelamarState();
}

class _ProsesPelamarState extends State<ProsesPelamar> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 60),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              // Nama Lengkap
              Text(
                "Nama Lengkap",
                style: AppFonts.body,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Mahasiswa A",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Gender
              Text("Gender", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Perempuan",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Tanggal Lahir
              Text("Tanggal Lahir", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "-",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Email
              Text("Email", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "MahasiswaMagang@gmail.com",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Nomor Handphone
              Text("Nomor Handphone", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "082414834298",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Pergururan Tinggi
              Text("Perguruan Tinggi", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "-",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // NIM
              Text("NIM", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "2149741912",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Program Studi
              Text("Prodi", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Informatika",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // CV
              Text("CV", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "canva.com/mahasiswaA",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Portofilio
              Text("Portofolio", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "figma.com/mahasiwaA",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Posisi
              Text("Posisi", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                height: 48,
                width: 328,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Front End",
                  style: AppFonts.body,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Status Penerimaan
              Text("Status Penerimaan", style: AppFonts.body),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: _selectedValue,
                items: <String>['Non', 'Proses', 'Lulus', 'Gagal']
                    .map((String value) {
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
                validator: (value) {
                  if (value == null) {
                    return 'Silakan pilih item';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () {
                    
                  },
                    child: Container(
                      alignment: Alignment.center,
                      width: 129,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Batal",
                        style: AppFonts.body.white,
                      ),
                    ),
                  ),
                  GestureDetector(onTap: () {
                    
                  },
                    child: Container(
                      alignment: Alignment.center,
                      width: 129,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Simpan",
                        style: AppFonts.body.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
               GestureDetector(onTap: () {
                    
                  },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 129,
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Hapus",
                          style: AppFonts.body.white,
                        ),
                      ),
                    ),
                  ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
