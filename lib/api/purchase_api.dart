import 'package:air_fryer_calculator/api/keys.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{
  static final _apiKey = AirFryrKeys.getRevenueCatKey();
  final fryerController = Get.put(FryerController());

  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration configuration = PurchasesConfiguration(_apiKey);
    //Removing boilerplate - the platform check is done in the keys file.
    // if (Platform.isAndroid) {
    //   configuration = PurchasesConfiguration(_apiKey);
    // } else if (Platform.isIOS) {
    //   configuration = PurchasesConfiguration(_apiKey);
    // }
    await Purchases.configure(configuration);
  }

  static Future<List<Offering>> fetchOffers() async{
    try{
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getAppPurchaseDate() async {
    String returnString = "Not Found";
    if (FryerPreferences.getAppPurchasedStatus() ?? false) {
      try {
        CustomerInfo customerInfo = await Purchases.getCustomerInfo();
        returnString = customerInfo.allPurchaseDates.values.first.toString();
      } on PlatformException catch (e) {
        //TODO: Write some logging here
      }
    }
    return returnString;
  }

  static Future<bool> restorePurchases() async {
    bool? restoreSuccess = false;
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      restoreSuccess = customerInfo.entitlements.all["AIr Fryr Pro"]?.isActive ;
    } on PlatformException catch (e) {
      // Error restoring purchases
    }
    return restoreSuccess ?? false;
  }
}