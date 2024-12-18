import 'package:KP_HUMIC/pages/main_page.dart';
import 'package:KP_HUMIC/pages/sign_up.dart';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:KP_HUMIC/themes/app_themes.extensions.dart';
import 'package:KP_HUMIC/widgets/text_form_fieldWidget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPagePeserta extends StatefulWidget {
  const LoginPagePeserta({super.key});

  @override
  State<LoginPagePeserta> createState() => _LoginPagePesertaState();
}

class _LoginPagePesertaState extends State<LoginPagePeserta> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsureText = true;
  bool _rememberme = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submitform() async {
    final storage = new FlutterSecureStorage();
    if (_formkey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;
      // Membuat body dari request
      final requestBody = {
        "email": email,
        "password": password,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://rest-api-penerimaan-kp-humic-5983663108.asia-southeast2.run.app/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == "Success") {
            debugPrint("User successfully registered");
            await storage.write(key: "authToken", value: responseData["token"] );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else {
            debugPrint("Registration failed: ${responseData['message']}");
          }
        } else {
          final errorData = jsonDecode(response.body);
          debugPrint("Server error: ${response.statusCode}");

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
    return Scaffold(backgroundColor: AppColors.white,appBar: AppBar(backgroundColor: AppColors.white,),
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Login",
                  style: AppFonts.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "isi form berikut untuk melanjutkan",
                  style: AppFonts.body,
                ),
                SizedBox(
                  height: 50,
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
                      _obsureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.gray2Color,
                    ),
                  ),
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  validator: formValidators.validatePassword,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Checkbox(
                      value: _rememberme,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberme = value ?? false;
                        });
                      }),
                  Expanded(
                    child: Text(
                      "Ingat Saya",
                      style: AppFonts.body,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Lupa Sandi?",
                          style: AppFonts.body,
                        )),
                  )
                ]),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: AppFonts.body,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Register",
                        style: AppFonts.body.secondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
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
                      "Login",
                      style: AppFonts.body.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
