import 'package:flutter/material.dart';
import 'package:bookmyshoot_camerarental/screen/home_screen.dart';
import 'package:bookmyshoot_camerarental/screen/Dashboard.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  // Add other route names as needed
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found!')),
      );
    });
  }
}