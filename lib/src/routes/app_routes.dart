import 'package:fast_location_app/src/modules/history/page/history_page.dart';
import 'package:fast_location_app/src/modules/home/page/home_page.dart';
import 'package:fast_location_app/src/modules/initial/page/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String history = '/history';
  static const String splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Página não encontrada'),
            ),
          ),
        );
    }
  }
}
