import 'package:fire_cars/auth/login.dart';
import 'package:fire_cars/views/profile/profile.dart';
import 'package:fire_cars/wrapper.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LayoutBuilder(
            builder: (context, constraints) {
              return Wrapper();
            },
          ),
        );
      case '/profile':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LayoutBuilder(
            builder: (context, constraints) {
              return Profile();
            },
          ),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LayoutBuilder(
            builder: (context, constraints) {
              return Login();
            },
          ),
        );
    }
  }
}
