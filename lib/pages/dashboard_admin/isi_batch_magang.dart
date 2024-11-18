import 'dart:convert';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class Batch {
  final String batchId;
  final String number;
  final String openedAt;
  final String closedAt;
  final String semester;
  final String year;
  final bool selectionAnnouncement;

  Batch({
    required this.batchId,
    required this.number,
    required this.openedAt,
    required this.closedAt,
    required this.semester,
    required this.year,
    required this.selectionAnnouncement,
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
      selectionAnnouncement: json['selection_announcement'], // Parse it here
    );
  }
}

class IsiBatchMagang extends StatefulWidget {
  final String batchId;
  const IsiBatchMagang({Key? key, required this.batchId}) : super(key: key);

  @override
  State<IsiBatchMagang> createState() => _IsiBatchMagangState();
}

class _IsiBatchMagangState extends State<IsiBatchMagang> {
  final _formkey = GlobalKey<FormState>();
  final _noBatchController = TextEditingController();
  final _semesterController = TextEditingController();
  final _tahunController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  String? _selectedValue;
  final List<Map<String, dynamic>> _listPengumuman = [
    {'value': 'true', 'label': 'Diumumkan'},
    {'value': 'false', 'label': 'Belum diumumkan'}
  ];

  DateTime? _startDate;
  DateTime? _endDate;
  Batch? _batch;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBatch();
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

  Future<void> _fetchBatch() async {
    setState(() {
      _isLoading = true;
    });
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "authToken");
    try {
      final response = await http.get(
        Uri.parse(
            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch/${widget.batchId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('data')) {
          final json = data['data'];
          setState(() {
            _batch = Batch.fromJson(json);
            _noBatchController.text = _batch?.number ?? '';
            _semesterController.text = _batch?.semester ?? '';
            _tahunController.text = _batch?.year ?? '';
            _startDateController.text = _batch?.openedAt ?? '';
            _endDateController.text = _batch?.closedAt ?? '';
            _selectedValue = _batch?.selectionAnnouncement.toString(); // Assign value to _selectedValue
          });
        } else {
          print('JSON structure does not contain "data" field');
        }
      } else {
        print('Failed to load batch. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Batch Magang",
                  style: AppFonts.display2.primary,
                ),
              ),
              SizedBox(height: 30),
              Text("No.batch", style: AppFonts.body),
              SizedBox(height: 10),
              TextFormField(
                controller: _noBatchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'No batch',
                ),
              ),
              SizedBox(height: 10),
              Text("Semester", style: AppFonts.body),
              SizedBox(height: 10),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(
                  labelText: 'Semester',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text("Tahun", style: AppFonts.body),
              SizedBox(height: 10),
              TextFormField(
                controller: _tahunController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Tahun',
                ),
              ),
              SizedBox(height: 10),
              Text("Periode", style: AppFonts.body),
              SizedBox(height: 10),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
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
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'To',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 10),
              Text("Pengumuman", style: AppFonts.body),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedValue,
                isExpanded: true,
                hint: Text('Pilih status pengumuman'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: _listPengumuman.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
                  return DropdownMenuItem<String>(
                    value: item['value'],
                    child: Text(item['label']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    // Parse the text from the date controllers back to DateTime
                    DateTime? openedAtDate = _startDate != null
                        ? _startDate
                        : DateFormat('dd/MM/yyyy').parse(_startDateController.text);
                    DateTime? closedAtDate = _endDate != null
                        ? _endDate
                        : DateFormat('dd/MM/yyyy').parse(_endDateController.text);

                    final requestBody = {
                      'selection_announcement': _selectedValue == 'true',
                      "number": _noBatchController.text,
                      "semester": _semesterController.text,
                      "year": _tahunController.text,
                      "opened_at": "${openedAtDate?.toIso8601String()}" + "Z",
                      "closed_at": "${closedAtDate?.toIso8601String()}" + "Z",
                    };

                    try {
                      final storage = FlutterSecureStorage();
                      String? token = await storage.read(key: "authToken");
                      final response = await http.put(
                        Uri.parse(
                            'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/batch/${widget.batchId}'),
                        headers: {
                          "Content-Type": "application/json",
                          "Authorization": "Bearer $token",
                        },
                        body: jsonEncode(requestBody),
                      );

                      debugPrint("Status code: ${response.statusCode}");
                      if (response.statusCode == 200) {
                        final responseData = jsonDecode(response.body);
                        if (responseData['status'] == "Success") {
                          debugPrint("Batch successfully updated");
                          _fetchBatch(); // Fetch updated data after successful update
                        } else {
                          debugPrint("Update failed: ${responseData['message']}");
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
                    fixedSize: Size(129, 45),
                  ),
                  child: Text(
                    'Simpan',
                    style: AppFonts.body2.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
