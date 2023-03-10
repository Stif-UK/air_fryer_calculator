import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/theme/theme_constants.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  //Get SharedPreferences
  await FryerPreferences.init();

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Air Fryer Calculator',
        theme: lightTheme,
        darkTheme: darkTheme,
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

