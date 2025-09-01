import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/controller/LanguageController.dart';
import 'package:air_fryer_calculator/l10n/l10n.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/privacy/initialise_screen.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:air_fryer_calculator/ui/first_use_demo/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
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

  //Check if user has seen the first use demo
  final hasSeenDemo = FryerPreferences.getHasSeenDemo() ?? false;

  final langController = Get.put(LanguageController());
  print(langController.locale.value);

  runApp(
       Provider.value(
         value: adState,
         builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Air Fryer Calculator',
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: ThemeMode.system,
            home: hasSeenDemo? const InitialiseScreen(targetWidget: const AirFryerHome()) : AirFryrOnboarding(),
           locale: langController.locale.value,
           supportedLocales: [
             Locale('en', ''),
             Locale('nl', ''),
             Locale('da', ''),
           ],
           localizationsDelegates: const[
             AppLocalizations.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate
           ],
          ),
       ),

  );
}



