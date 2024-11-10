import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/admin_dashboard.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/form_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/isi_batch_magang.dart';
import 'package:kphumic_tel_u_bandung/pages/dashboard_admin/profile_admin.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Batch {
  final String batchId;
  final String number;
  final String openedAt;
  final String closedAt;
  final String semester;
  final String year;

  Batch({
    required this.batchId,
    required this.number,
    required this.openedAt,
    required this.closedAt,
    required this.semester,
    required this.year,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    DateTime openedAtDate = DateTime.parse(json['opened_at']);
    DateTime closedAtDate = DateTime.parse(json['closed_at']);

    String formattedOpenedAt = DateFormat('dd/MM/yyyy').format(openedAtDate);
    String formattedClosedAt = DateFormat('dd/MM/yyyy').format(closedAtDate);

    return Batch(
      batchId: json['batch_id'].toString(),
      number: json['number'].toString(),
      openedAt: formattedOpenedAt,
      closedAt: formattedClosedAt,
      semester: json['semester'],
      year: json['year'].toString(),
    );
  }
}

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

  DateTime? _startDate;
  DateTime? _endDate;

  List<Batch> _batches = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBatches();
  }

  Future<void> _fetchBatches() async {
    setState(() {
      _isLoading = true;
    });
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    try {
      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('data')) {
          final List<dynamic> batchList = data['data'];
          setState(() {
            _batches = batchList.map((json) => Batch.fromJson(json)).toList();
          });
        } else {
          print('JSON structure does not contain "data" field');
        }
      } else {
        print('Failed to load batches. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: GNav(
        activeColor: AppColors.primary,
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        iconSize: 30,
        tabs: [
          GButton(icon: Icons.home_outlined),
          GButton(icon: Icons.date_range_outlined),
          GButton(icon: Icons.badge_outlined),
          GButton(icon: Icons.person_outline),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Batch Magang",
                    style: AppFonts.display2.primary,
                  )),
              SizedBox(
                height: 30,
              ),
              Text("No.batch",style: AppFonts.body,),SizedBox(height: 10,),
              TextFormField(
                controller: _noBatchController,
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(),
                  labelText: 'No batch',
                ),
              ),
              SizedBox(height: 10),
              Text("Semester",style: AppFonts.body,),SizedBox(height: 10,),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(labelText: 'Semester',enabledBorder: OutlineInputBorder(),),
              ),
              SizedBox(height: 10),
              Text("Tahun",style: AppFonts.body,),SizedBox(height: 10,),
              TextFormField(
                controller: _tahunController,
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(),labelText: 'Tahun'),
              ),
              SizedBox(height: 10),
              Text("Periode",style: AppFonts.body,),SizedBox(height: 10,),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(),
                  labelText: 'From',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 10),
        
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(),
                  labelText: 'To',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 20),
              Align(alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    // Parse the text from the date controllers back to DateTime
                
                    DateTime? openedAtDate = _startDate != null
                        ? _startDate
                        : DateFormat('dd/MM/yyyy')
                            .parse(_startDateController.text);
                    DateTime? closedAtDate = _endDate != null
                        ? _endDate
                        : DateFormat('dd/MM/yyyy').parse(_endDateController.text);
                
                    final requestBody = {
                      "number": _noBatchController.text,
                      "semester": _semesterController.text,
                      "year": _tahunController.text,
                      "opened_at": "${openedAtDate?.toIso8601String()}" + "Z",
                      "closed_at": "${closedAtDate?.toIso8601String()}" + "Z",
                    };
                    try {
                      final storage = FlutterSecureStorage();
                      String? token = await storage.read(key: "authToken");
                      final response = await http.post(
                        Uri.parse(
                            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch'),
                        headers: {
                          "Content-Type": "application/json",
                          "Authorization": "Bearer $token"
                        },
                        body: jsonEncode(requestBody),
                      );
                
                      debugPrint("status code ${response.statusCode}");
                      if (response.statusCode == 201) {
                        final responseData = jsonDecode(response.body);
                        if (responseData['status'] == "Success") {
                          debugPrint("User successfully registered");
                          @override
                          void initState() {
                            super.initState();
                            _fetchBatches();
                          }
                        } else {
                          debugPrint(
                              "Registration failed: ${responseData['message']}");
                        }
                      } else {
                        final errorData = jsonDecode(response.body);
                        debugPrint("Server error: ${response.statusCode}");
                        debugPrint("Error message: ${errorData['message']}");
                      }
                    } catch (e) {
                      debugPrint("Error: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    fixedSize: Size(129, 45)
                  ),
                  child: Text(
                    'Simpan',
                    style: AppFonts.body2.white,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(color: AppColors.primary,child: Text("Batch Magang",style: AppFonts.body2.white,textAlign: TextAlign.center,),),
              SizedBox(height: 10,),
              Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Batch", style: TextStyle(color: Colors.white)),
                      Text("Periode", style: TextStyle(color: Colors.white)),
                      Text("Action", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              
              SizedBox(height: 10),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: _batches.map((batch) {
                        return GestureDetector(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => IsiBatchMagang(batchId: batch.batchId)));
                        },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade300)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(batch.number),
                                Text("${batch.openedAt} - ${batch.closedAt}"),
                                IconButton(
                                  icon: Icon(Icons.delete, color: AppColors.primary),
                                  onPressed: () async {
                                    final String id = batch.batchId;
                                    final storage = FlutterSecureStorage();
                                    String? token =
                                        await storage.read(key: "authToken");
                                    try {
                                      final response = await http.delete(
                                        Uri.parse(
                                            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch/${id}'),
                                        headers: {
                                          'Authorization': 'Bearer $token',
                                        },
                                      );
                                      @override
                                      void initState() {
                                        super.initState();
                                        _fetchBatches();
                                      }
                                    } catch (error) {}
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
