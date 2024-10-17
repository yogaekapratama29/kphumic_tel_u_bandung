import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/splashScreen.dart';
import 'package:kphumic_tel_u_bandung/pages/started_page.dart';
import 'package:kphumic_tel_u_bandung/routes/app_route_name.dart';
import 'package:kphumic_tel_u_bandung/routes/app_route_paths.dart';

class AppRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: AppRoutePaths.Splashscreen,
      name: AppRouteName.Splashscreen.name,
      builder: (context, state) => Splashscreen(),
    ),
    GoRoute(
      path: AppRoutePaths.LoginPage,
      name: AppRouteName.LoginPage.name,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: AppRoutePaths.MainPage,
      name: AppRouteName.MainPage.name,
      builder: (context, state) => MainPage(),
    ),
   GoRoute(
      path: AppRoutePaths.StartedPage,
      name: AppRouteName.StartedPage.name,
      builder: (context, state) => StartedPage(),
    ),
  ];

  // Variabel Location
  static GoRouter setupRouter([String? location]) {
    return GoRouter(
        initialLocation: location ?? AppRoutePaths.Splashscreen,
        debugLogDiagnostics: !kReleaseMode,
        routes: routes);
  }
}
