import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/theme/theme_constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialise Ads
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  //Initialise RevenueCat
  await PurchaseApi.init();

  //Load the theme from assets
  final themeStrLight = await rootBundle.loadString('assets/theme/appainter_theme.json');
  final themeJsonLight = jsonDecode(themeStrLight);
  final themeLight = ThemeDecoder.decodeThemeData(themeJsonLight);

  final themeStrDark = await rootBundle.loadString('assets/theme/appainter_theme_dark.json');
  final themeJsonDark = jsonDecode(themeStrDark);
  final themeDark = ThemeDecoder.decodeThemeData(themeJsonDark);

  //Initialise database
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  await Hive.openBox<Notes>("NoteBook");

  //Get SharedPreferences
  await FryerPreferences.init();

  //Ensure temperature scale preference is instantiated in preferences
  if(FryerPreferences.getTemperaturePreference() == null){
    FryerPreferences.setTemperaturePreference(true);
  }

  //Ensure app purchase status is instantiated in preferences
  if(FryerPreferences.getAppPurchasedStatus() == null){
    FryerPreferences.setAppPurchasedStatus(false);
  }

  //Track how many times the user has opened the app
  int openCount = FryerPreferences.getOpenCount() ?? 0;
  FryerPreferences.setOpenCount(openCount +1);


  runApp(
       Provider.value(
         value: adState,
         builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Air Fryer Calculator',
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: ThemeMode.system,
            home: const AirFryerHome(),
          ),
       ),

  );
}



