import 'package:flutter/material.dart';
import 'package:bookmyshoot_camerarental/worldtime/Home.dart';
import 'package:bookmyshoot_camerarental/worldtime/choosing_location.dart';
import 'package:bookmyshoot_camerarental/worldtime/loading.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },
    );
  }
}