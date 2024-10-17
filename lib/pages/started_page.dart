import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';
import 'package:kphumic_tel_u_bandung/themes/app_fonts.dart';
import 'package:kphumic_tel_u_bandung/themes/app_themes.extensions.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({super.key});

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Text(
                  "Ayo Mulai",
                  style: AppFonts.title.black,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Daftar atau Login untuk mendapatkan pengalaman yang lebih baik",
                  style: AppFonts.body.black,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          SizedBox(
            height: 56,
          ),
           Container(width: 327,height: 54,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.black),
                    ),
                  ),
                  child: Text('Masuk Sebagai Peserta',style: AppFonts.body.white,),
                ),
              ),
          SizedBox(
            height: 12,
          ),
           Container(width: 327,height: 54,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.black),
                    ),
                  ),
                  child: Text('Masuk Sebagai Admin',style: AppFonts.body.white,),
                ),
              ),
          SizedBox(
            height: 24,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.accent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR',style: AppFonts.body.black,),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(onTap: () {}, child: Text("Register",style: AppFonts.body.black,))
        ],
      ),
    ));
  }
}