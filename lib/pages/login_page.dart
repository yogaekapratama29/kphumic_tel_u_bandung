import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/widgets/text_form_fieldWidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextFormFieldwidget(
              hintText: "Email",
              controller: TextEditingController(),
              textInputAction: TextInputAction.done)),
    );
  }
}
