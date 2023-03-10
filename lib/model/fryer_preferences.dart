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


  //Getters and setters

//Getter and setter for app open count int
  static int? getOpenCount() => _preferences.getInt(_keyOpenCount);

  static Future setOpenCount(int openCount) async =>
      await _preferences.setInt(_keyOpenCount, openCount);

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

}