import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';



// Class untuk Validator nya
class formValidators
 {
  // Validasi Full Name
  static String? validateFullName (String? value){
  if(value == null || value.isEmpty){
    return "Please enter your Full Name";
  }
  // RegExp(Regular Expresion) = pattern String mengecek karakter secara berurutan
  if(RegExp(r"[0-9]").hasMatch(value)){
    return "Full name cannot contain numbers";
  }
  return null;
}
// Validasi Email
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your Email";
    }
    // Regular Expression untuk karakter
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
      return "Please enter a valid email";
    }
    return null;
  }
// Validasi Password
  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your Password";
    }
    if(value.length < 8){
      return "Password must be at least 8 characters";
    }
    return null;
  }

// Validasi NIM
    static String? validateNIM(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your NIM (Student ID)";
    }
    if(value.length < 10){
      return "NIM (Student ID) must be at least 10 characters";
    }
    return null;
  }

// Validasi Perguruan Tinggi
    static String? validatePerguruanTinggi(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your University";
    }
    return null;
  }

// Validasi Prodi
    static String? validateProdi(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your Program Studi (Major)";
    }
    return null;
  }
// Validasi No Handphone
static String? validateNoWa(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your Nomor Handphone (nomor WA)";
    }
    if(value.length < 7){
      return "Nomor Handphone must be at least 7 digits";
    }
    return null;
  }
}


class TextFormFieldwidget extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  const TextFormFieldwidget({
    super.key,
    required this.hintText,
    this.obsecureText = false,
    required this.controller,
    required this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      obscuringCharacter: "*",
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppFonts.body,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.accent),
          ),
          // Border Fokus
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.secondary,
              )),
          // Border Fokus Error
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primary,
              )),
          filled: true,
          fillColor: AppColors.white,
          suffixIcon: suffixIcon == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(top: 21, bottom: 21, right: 27),
                  child: suffixIcon,
                ),
          prefixIcon: prefixIcon == null
              ? null
              : Padding(
                  padding:
                      EdgeInsets.only(top: 21, bottom: 21, left: 18, right: 20),
                  child: prefixIcon,
                ),),
                validator: validator ,
    );
  }
}
