import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page_admin.dart';
import 'package:kphumic_tel_u_bandung/pages/login_page_peserta.dart';
import 'package:kphumic_tel_u_bandung/pages/main_page.dart';
import 'package:kphumic_tel_u_bandung/pages/sign_up.dart';
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
      path: AppRoutePaths.LoginPagePeserta,
      name: AppRouteName.LoginPagePeserta.name,
      builder: (context, state) => LoginPagePeserta(),
    ),
    GoRoute(
      path: AppRoutePaths.LoginPageAdmin,
      name: AppRouteName.LoginPageAdmin.name,
      builder: (context, state) => LoginPageAdmin(),
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
     GoRoute(
      path: AppRoutePaths.SignUp,
      name: AppRouteName.SignUp.name,
      builder: (context, state) => SignUp(),
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
