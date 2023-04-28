import 'package:air_fryer_calculator/copy/version_history_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:get/get.dart';

///This class provides helper methods that can be called at app startup to determine whether or not to
///display information to the user, such as notification that the app has updated
class StartupChecksUtil{


  ///runStartupChecks() is the only method which should be called externally.
  ///This will determine what, if any, dialogue should be returned and displayed
  ///on top of the passed context
  static runStartupChecks() async {
    bool _showWhatsNew = await returnWhatsNew();


    //Checks should be run in priority order with only one dialog triggered
    //1. Check if we should show a 'what's new' dialog
    if(_showWhatsNew){
      showWhatsNewDialog();

      StartupChecksUtil.updateLatestVersion();
    }

      }



  static Future<bool> returnWhatsNew() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version.toString();
    String? latestAppVersion = FryerPreferences.getLatestVersion();
    return latestAppVersion == null? true : _isVersionGreaterThan(currentVersion, latestAppVersion);

  }

  static bool _isVersionGreaterThan(String currentVersion, String latestAppVersion){
    List<String> lastV = latestAppVersion.split(".");
    List<String> newV = currentVersion.split(".");
    bool a = false;
    for (var i = 0 ; i <= 2; i++){
      a = int.parse(newV[i]) > int.parse(lastV[i]);
      if(int.parse(newV[i]) != int.parse(lastV[i])) break;
    }
    return a;
  }

  static updateLatestVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version.toString();
    FryerPreferences.setLatestVersion(currentVersion);

  }

  static showWhatsNewDialog(){
    Get.defaultDialog(
      title: "What's New?",
      content: Container(
        height: Get.height*0.4,
        width: Get.width*0.8,
        child: VersionHistoryCopy.getLatestVersionCopy(),
      )
      //VersionHistoryCopy.getLatestVersionCopy(),
    );
  }
}