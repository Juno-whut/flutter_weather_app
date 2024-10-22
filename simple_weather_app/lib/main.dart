import 'package:flutter/material.dart';
// 2 different style weather apps that both do the same job but with different approachs and different designs
// After building both i like weather_page.dart more than homepage.dart
import 'package:simple_weather_app/pages/weather_page.dart';
// import 'package:simple_weather_app/pages/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.lightBlue),
      home: const WeatherPage(),
    );
  }
}
