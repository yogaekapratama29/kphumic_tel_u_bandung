import 'package:flutter/material.dart';

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


  void _submitform(){
    if(_formkey.currentState?.validate() ?? false){
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
    }
    else{
      debugPrint("Form is Invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}