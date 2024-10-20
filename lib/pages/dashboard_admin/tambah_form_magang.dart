import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class TambahFormMagang extends StatefulWidget {
  @override
  _TambahFormMagangState createState() => _TambahFormMagangState();
}

class _TambahFormMagangState extends State<TambahFormMagang> {
  String? _status = 'Dibuka'; 
  Color _statusColor = Colors.green; // tidak digunakan belum cocok

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                SizedBox(height: 16),
                Text("Posisi",style: AppFonts.body,),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'Front end',
                ),
                SizedBox(height: 16),
                Text("Deskripsi",style: AppFonts.body,),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(),
                  ),
                  initialValue:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
                SizedBox(height: 16),
                Text("Status Magang",style: AppFonts.body,),
                SizedBox(height: 10,),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(),
                    
                  ),
                  items: <String>['Dibuka', 'Ditutup'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _status = newValue;
                      _statusColor =
                          (newValue == 'Dibuka') ? Colors.green : Colors.red;
                    });
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
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
                    GestureDetector(
                      onTap: () {},
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
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
