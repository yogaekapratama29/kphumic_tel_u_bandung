import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';


// Class untuk Validator nya
class formValidators
 {
  // Validasi Full Name
  static String? validateFullName (String? value){
  if(value == null || value.isEmpty){
    return "Please enter your name";
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
      return "Please enter your email";
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
      return "Please enter your password";
    }
    if(value.length < 8){
      return "Password must be at least 8 characters";
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
          hintStyle: AppFonts.body.gray2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          // Border Fokus
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: AppColors.primary,
              )),
          // Border Fokus Error
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
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
