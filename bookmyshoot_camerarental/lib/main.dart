import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookmyshoot_camerarental/screen/home_screen.dart';
import 'package:bookmyshoot_camerarental/screen/dashboard.dart';
import 'package:bookmyshoot_camerarental/screen/rent_equipment_screen.dart';
import 'package:bookmyshoot_camerarental/utils/theme.dart';
import 'package:bookmyshoot_camerarental/providers/theme_provider.dart';

void main() {
  runApp(const BookMyShootApp());
}

class BookMyShootApp extends StatelessWidget {
  const BookMyShootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'BookMyShoot',
            theme: themeProvider.isDarkMode ? appTheme : lightAppTheme,
            initialRoute: Routes.home,
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            routes: {
              Routes.home: (context) => const HomeScreen(),
              Routes.dashboard: (context) => const DashboardScreen(),
              Routes.rent: (context) => const RentEquipmentScreen(),
            },
          );
        },
      ),
    );
  }
}

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String rent = '/rent'; // Add this route constant
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.rent:
        return MaterialPageRoute(builder: (_) => const RentEquipmentScreen()); // Add this case
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