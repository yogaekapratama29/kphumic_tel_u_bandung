import 'dart:async';

import 'package:KP_HUMIC/routes/app_route_name.dart';
import 'package:KP_HUMIC/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(Duration(seconds: 3), callback);
  }

  // call back router PageRoute
  void callback(){
    context.goNamed(AppRouteName.StartedPage.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [Image.asset("assets/logoKPHumic.png",width: 328,height: 113,),
          ]
        ),
      )),
    );
  }
}
