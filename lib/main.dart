import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kphumic_tel_u_bandung/routes/app_routes.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _appRouter = AppRoutes.setupRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "KPHumic Telkom University Bandung",
      debugShowCheckedModeBanner: !kReleaseMode,
      routerConfig: _appRouter,
    );
  }
}