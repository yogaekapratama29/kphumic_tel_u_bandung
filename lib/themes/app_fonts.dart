import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts{
  static TextStyle display1 = GoogleFonts.yesevaOne(
    fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black);
  static TextStyle display2 = GoogleFonts.yesevaOne(
    fontSize: 32, fontWeight: FontWeight.w400, color: Colors.black);
  static TextStyle title = GoogleFonts.workSans(
    fontSize: 26, fontWeight: FontWeight.w500, color: Colors.black);
  static TextStyle caption = GoogleFonts.workSans(
    fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black);

  // Body
  static TextStyle body = GoogleFonts.workSans(
    fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
  static TextStyle body2 = GoogleFonts.workSans(
    fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black);
  
  // Lain-lain
  static TextStyle buttonText = GoogleFonts.workSans(
    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
  static TextStyle small = GoogleFonts.workSans(
    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
}