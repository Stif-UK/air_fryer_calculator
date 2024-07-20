import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class FryerPreferences {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();


  //Instance variables
  static const _keyOpenCount = 'openCount';
  static const _keyAppPurchased = 'appPurchased';
  static const _keyAppReviewPrompt = 'appReviewPrompt';
  static const _keyLatestVersion = 'latestAppVersion';
  static const _keyTempPreference = 'temperaturePreference';
  static const _keyFirstUseDate = 'firstUseDate';
  static const _keyLastReviewPrompt = 'lastReviewPrompt';
  static const _keyLastEntitlementCheck = 'lastEntitlementCheck';
  static const _keyLastSalePromptDismissed = 'lastSalePromptDismissed';
  //First Use Demo
  static const _keyFirstDemo = 'firstUseDemo';
  //locale
  static const _keyLocale = 'locale';


  //Getters and setters

//Getter and setter for app open count int
  static int? getOpenCount() => _preferences.getInt(_keyOpenCount);

  static Future setOpenCount(int openCount) async =>
      await _preferences.setInt(_keyOpenCount, openCount);

  //Getter and setter for first use demo
  static Future setHasSeenDemo(bool hasSeenDemo) async =>
      await _preferences.setBool(_keyFirstDemo, hasSeenDemo);

  static bool? getHasSeenDemo() => _preferences.getBool(_keyFirstDemo);

  //Getter and setter for purchased bool
  static bool? getAppPurchasedStatus() => _preferences.getBool(_keyAppPurchased);

  static Future setAppPurchasedStatus(bool appPurchased) async =>
      await _preferences.setBool(_keyAppPurchased, appPurchased);

  //Getter and setter for latest app version String
  static Future setLatestVersion(String latestVersion) async =>
      await _preferences.setString(_keyLatestVersion, latestVersion);

  static String? getLatestVersion() => _preferences.getString(_keyLatestVersion);

  //Getter and setter for app review prompted bool
  static bool? getAppReviewPrompted() => _preferences.getBool(_keyAppReviewPrompt);

  static Future setAppReviewPrompted(bool appReviewPrompted) async =>
      await _preferences.setBool(_keyAppReviewPrompt, appReviewPrompted);

  //Getter and setter for purchased bool
  static bool? getTemperaturePreference() => _preferences.getBool(_keyTempPreference);

  static Future setTemperaturePreference(bool tempPreference) async =>
      await _preferences.setBool(_keyTempPreference, tempPreference);

  //Getter and Setter for first open date
  static DateTime? getFirstUseDate() {
    String? returnString = _preferences.getString(_keyFirstUseDate);
    return returnString == null? null : DateTime.parse(returnString);
  }

  static Future setFirstUseDate(DateTime firstUsed) async{
    await _preferences.setString(_keyFirstUseDate, firstUsed.toString());
  }

  //Getter and Setter for last review prompt date
  static DateTime? getLastReviewPromptDate() {
    String? returnString = _preferences.getString(_keyLastReviewPrompt);
    return returnString == null? null : DateTime.parse(returnString);
  }

  static Future setLastReviewPromptDate(DateTime lastReviewDate) async{
    await _preferences.setString(_keyLastReviewPrompt, lastReviewDate.toString());
  }

  //Getter and Setter for last entitlement check date
  static DateTime? getLastEntitlementCheckDate() {
    String? returnString = _preferences.getString(_keyLastEntitlementCheck);
    return returnString == null? null : DateTime.parse(returnString);
  }

  static Future setLastEntitlementCheckDate(DateTime lastEntitlementCheck) async{
    await _preferences.setString(_keyLastEntitlementCheck, lastEntitlementCheck.toString());
  }

  //Getter and Setter for last sale prompt acknowledged
  static DateTime? getLastSalePrompt() {
    String? returnString = _preferences.getString(_keyLastSalePromptDismissed);
    return returnString == null? null : DateTime.parse(returnString);
  }

  static Future setLastSalePrompt(DateTime lastSalePrompt) async{
    await _preferences.setString(_keyLastSalePromptDismissed, lastSalePrompt.toString());
  }

  //Getter and Setter for locale
  static Future setLocalePreference(String locale) async {
    await _preferences.setString(_keyLocale, locale);
  }

  static String getLocalePreference() {
    return _preferences.getString(_keyLocale) ?? "en";
}

}