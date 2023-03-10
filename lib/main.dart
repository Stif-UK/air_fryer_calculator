import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/theme/theme_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Fryer Calculator',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: AirFryerHome(),
    )
  }
}

