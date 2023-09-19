import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../screens/Home_screen.dart';
import '../screens/free_luch_update_Screen.dart';

class NavigationManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HngRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case HngRoutes.freeLunchUpdate:
        return MaterialPageRoute(builder: (_) => const FreeLunchUpdateScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}
