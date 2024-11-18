import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:KP_HUMIC/themes/app_fonts.dart';
import 'package:flutter/material.dart';


class AlurMagang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _stepByStep("Log in", false),
              _stepByStep("Input Data yang Dibutuhkan", false),
              _stepByStep("Pendaftaran KP", false),
              _stepByStep("Seleksi", false),
              _stepByStep("On Job", false),
              _stepByStep("Lulus", true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepByStep(String stepTitle, bool isLastStep) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLastStep)
              Container(
                width: 2,
                height: 40, // tinggi garis
                color: AppColors.accent,
              ),
          ],
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            stepTitle,
            style: AppFonts.body2
          ),
        ),
      ],
    );
  }
}
