import 'package:KP_HUMIC/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter,
    );
  }
}