import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/routes.dart';
import 'package:hng_events_app/features/events/timeline_screen/timeline_screen.dart';

class NavigationManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HngRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const TimelineScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
