import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class TambahFormMagang extends StatefulWidget {
  @override
  _TambahFormMagangState createState() => _TambahFormMagangState();
}

class _TambahFormMagangState extends State<TambahFormMagang> {
  String? _status = 'Dibuka';
  Color _statusColor = Colors.green;

  // Controller 
  TextEditingController _namaPosisiController = TextEditingController();
  TextEditingController _deskripsiPosisiController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;


  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _startDateController.text = DateFormat('dd/MM/yyyy').format(picked);
        } else {
          _endDate = picked;
          _endDateController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white,
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
                Text("Periode", style: AppFonts.body),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                          label: 'From',
                          controller: _startDateController,
                          onTap: () => _selectDate(context, true)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildDateField(
                          label: 'To',
                          controller: _endDateController,
                          onTap: () => _selectDate(context, false)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text("Status Magang", style: AppFonts.body),
                SizedBox(height: 10),
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
                      onTap: () {
                        _saveForm();
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
                SizedBox(height: 50),
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

  // fungsi untuk data picker
  Widget _buildDateField(
      {required String label,
      required TextEditingController controller,
      required Function onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.body),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () => onTap(),
        ),
      ],
    );
  }

  // untuk save data ke container yg baru
  void _saveForm() {
    if (_startDate != null && _endDate != null) {
      Map<String, dynamic> newMagang = {
        "name": _namaPosisiController.text,  
        "description": _deskripsiPosisiController.text,  
        "status": _status,
        "color": _status == 'Dibuka' ? "green" : "red",
        "startDate": _startDate,  
        "endDate": _endDate,     
      };
      Navigator.pop(context, newMagang);
    } else {
    
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Silakan pilih periode mulai dan akhir."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}




