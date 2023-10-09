import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/copy/version_history_copy.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/remove_ads.dart';
import 'package:air_fryer_calculator/util/string_extention.dart';
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
    //2. If not showing a what's new dialog, check if a sale dialog should show
    else{
      checkForSale();
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

  static checkForSale() async {
    //fetchOffers only ever returns the a list with a single entry, the currently active offer
    final offerings = await PurchaseApi.fetchOffers();
    String? title;
    String? description;
    try {
      //Try to access the title and description of the offer - if more than one entry has been returned this will throw an error
      title = offerings.map((offer) => offer.identifier).single;
      description = offerings.map((offer) => offer.serverDescription).single;
      //if we successfully get the offer, check if the title includes the word 'sale' then display a dialog
      if(title.containsSale){
        Get.defaultDialog(
          title: title,
          content: Container(
            child: Text(description),
          ),
          textConfirm: "Show me",
          textCancel: "No Thanks",
          onConfirm: () => Get.to(() => RemoveAds())
        );
      }
    } on Error catch (e) {
      print("Error caught trying to identify single RevenueCat offering: ${e.toString()}");
    }

    print(offerings.map((e) => e.serverDescription));
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