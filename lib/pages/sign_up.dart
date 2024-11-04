import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page_peserta.dart';
import 'package:kphumic_tel_u_bandung/pages/started_page.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';
import 'package:kphumic_tel_u_bandung/widgets/text_form_fieldWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _nimController = TextEditingController();
  final _perguruanTinggiController = TextEditingController();
  final _prodiController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsureText = true;

  @override
  void dispose() {
    _fullnameController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _perguruanTinggiController.dispose();
    super.dispose();
  }

  void _submitform() async {
    if (_formkey.currentState?.validate() ?? false) {
      final fullName = _fullnameController.text;
      final nim = _nimController.text;
      final perguruan_tinggi = _perguruanTinggiController.text;
      final prodi = _prodiController.text;
      final phone_number = _phoneNumberController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      // Membuat body dari request
      final requestBody = {
        "full_name": fullName,
        "nim": nim,
        "perguruan_tinggi": perguruan_tinggi,
        "prodi": prodi,
        "phone_number": phone_number,
        "email": email,
        "password": password,
      };

      try {
        // Lakukan POST request ke endpoint register
        final response = await http.post(
          Uri.parse(
              'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        debugPrint("fullname ${fullName}");
        debugPrint("status code ${response.statusCode}");
        if (response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == "Success") {
            debugPrint("User successfully registered");

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPagePeserta()),
            );
          } else {
            debugPrint("Registration failed: ${responseData['message']}");
          }
        } else {
          final errorData = jsonDecode(response.body);
          debugPrint("Server error: ${response.statusCode}");
          debugPrint("Error message: ${errorData['message']}");
        }
      } catch (e) {
        debugPrint("Error: $e");
      }
    } else {
      debugPrint("Form is Invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Register",
                style: AppFonts.title,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Daftarkan sekarang juga untuk mendapatkan pengalaman",
                style: AppFonts.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormFieldwidget(
                        hintText: "Nama Lengkap",
                        controller: _fullnameController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validateFullName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "NIM",
                        controller: _nimController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validateNIM,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "Perguruan Tinggi",
                        controller: _perguruanTinggiController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validatePerguruanTinggi,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "Prodi",
                        controller: _prodiController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validateProdi,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "Nomor Handphone (WhatsApp)",
                        controller: _phoneNumberController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validateNoWa,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "Email",
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: formValidators.validateEmail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldwidget(
                        hintText: "Sandi",
                        obsecureText: _obsureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obsureText = !_obsureText;
                            });
                          },
                          child: Icon(
                            size: 20,
                            _obsureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.gray2Color,
                          ),
                        ),
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        validator: formValidators.validatePassword,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah punya akun?",
                            style: AppFonts.body,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartedPage()));
                            },
                            child: Text(
                              "Login",
                              style: AppFonts.body.secondary,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          _submitform();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 375,
                          height: 54,
                          decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "Register",
                            style: AppFonts.body.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
