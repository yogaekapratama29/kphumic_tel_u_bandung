import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/admin_dashboard.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/form_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/profile_admin.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';
import 'package:kphumic_tel_u_bandung/widgets/text_form_fieldWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BatchMagang extends StatefulWidget {
  const BatchMagang({super.key});

  @override
  State<BatchMagang> createState() => _BatchMagangState();
}

class _BatchMagangState extends State<BatchMagang> {
  final _formkey = GlobalKey<FormState>();
  final _noBatchController = TextEditingController();
  final _semesterController = TextEditingController();
  final _tahunController = TextEditingController();
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

  void _submitform() {
    if (_formkey.currentState?.validate() ?? false) {
      final noBatch = _noBatchController;
      final semester = _semesterController;
      final tahun = _tahunController;

      debugPrint("Form is Valid");
      debugPrint("No Batch : $noBatch");
      debugPrint("NIM : $semester");
      debugPrint("Tahun : $tahun");
    } else {
      debugPrint("Form is Invalid");
    }
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormMagang()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileAdmin()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: GNav(
          activeColor: AppColors.primary,
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          iconSize: 30,
          tabs: [
            GButton(
              icon: Icons.home_outlined,
            ),
            GButton(
              icon: Icons.date_range_outlined,
            ),
            GButton(
              icon: Icons.badge_outlined,
            ),
            GButton(
              icon: Icons.person_outline,
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Batch Magang",
              style: AppFonts.display2.primary,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // form No.batch
                        Text(
                          "No batch",
                          style: AppFonts.body,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldwidget(
                          hintText: "1",
                          controller: _noBatchController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // form Semester
                        Text(
                          "Semester",
                          style: AppFonts.body,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldwidget(
                          hintText: "Genap",
                          controller: _semesterController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // form Semester
                        Text(
                          "Semester",
                          style: AppFonts.body,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldwidget(
                          hintText: "2024",
                          controller: _tahunController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // form Periode
                        Text(
                          "Periode",
                          style: AppFonts.body,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
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
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 400,
                          height: 31,
                          color: AppColors.primary,
                          child: Text(
                            "Batch Magang",
                            style: AppFonts.body2.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 400,
                          height: 31,
                          color: AppColors.primary,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Batch",
                                  style: AppFonts.body2.white,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Text(
                                  "Periode",
                                  style: AppFonts.body2.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Content
                        Container(
                          width: 400,
                          height: 46,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border:
                                  Border.all(color: AppColors.accent, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "1",
                                  style: AppFonts.body2,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "21/04/2024 - 21/06/2024",
                                  style: AppFonts.body2,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(MdiIcons.dotsHorizontal)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                         // Content
                        Container(
                          width: 400,
                          height: 46,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border:
                                  Border.all(color: AppColors.accent, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "2",
                                  style: AppFonts.body2,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "21/04/2024 - 21/11/2024",
                                  style: AppFonts.body2,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(MdiIcons.dotsHorizontal)),
                            ],
                          ),
                        ),
                      ])),
            )
          ]),
        )));
  }
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
