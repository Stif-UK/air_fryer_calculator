import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/theme/theme_constants.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Load the theme from assets
  final themeStrLight = await rootBundle.loadString('assets/theme/appainter_theme.json');
  final themeJsonLight = jsonDecode(themeStrLight);
  final themeLight = ThemeDecoder.decodeThemeData(themeJsonLight);

  final themeStrDark = await rootBundle.loadString('assets/theme/appainter_theme_dark.json');
  final themeJsonDark = jsonDecode(themeStrDark);
  final themeDark = ThemeDecoder.decodeThemeData(themeJsonDark);


  //Get SharedPreferences
  await FryerPreferences.init();

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Air Fryer Calculator',
        theme: themeLight,
        darkTheme: themeDark,
        themeMode: ThemeMode.system,
        home: const AirFryerHome(),
      )
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   //Get SharedPreferences
//   await FryerPreferences.init();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Air Fryer Calculator',
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       themeMode: ThemeMode.system,
//       home: AirFryerHome(),
//     );
//   }
// }

