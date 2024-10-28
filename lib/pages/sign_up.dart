import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page_peserta.dart';
import 'package:kphumic_tel_u_bandung/pages/started_page.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';
import 'package:kphumic_tel_u_bandung/widgets/text_form_fieldWidget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _nimController = TextEditingController();
  final _prodiController = TextEditingController();
  final _nomerWAController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsureText = true;

  @override
  void dispose() {
    _fullnameController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    _nomerWAController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitform() {
    if (_formkey.currentState?.validate() ?? false) {
      final fullName = _fullnameController;
      final nim = _nimController;
      final prodi = _prodiController;
      final nomerWA = _nomerWAController;
      final email = _emailController;
      final password = _passwordController;

      debugPrint("Form is Valid");
      debugPrint("Full Name : $fullName");
      debugPrint("NIM : $nim");
      debugPrint("Prodi : $prodi");
      debugPrint("Nomer Wa : $nomerWA");
      debugPrint("Email Address : $email");
      debugPrint("Password : $password");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPagePeserta()));
    } else {
      debugPrint("Form is Invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: AppColors.white,),
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
                        controller: _nomerWAController,
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
                          child: Icon(size: 20,
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
