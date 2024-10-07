import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/themes/app_colors.dart';

class MainPageContents extends StatelessWidget {
  final String image;
  const MainPageContents({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Image.asset(
          image,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ))
      ],
    );
  }
}
