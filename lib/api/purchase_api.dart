import 'package:air_fryer_calculator/api/keys.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/errors/error_handling.dart';
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
      showSuccessDialog();
      return true;
    } catch (e) {
      if(e is PlatformException) {
        AirFryrErrorHandling.handlePurchaseError(e);
      }
      return false;
    }
  }

  static Future<String> getAppPurchaseDate(bool first) async {
    String returnString = "Not Found";
    if (FryerPreferences.getAppPurchasedStatus() ?? false) {
      try {
        CustomerInfo customerInfo = await Purchases.getCustomerInfo();
        returnString = first? customerInfo.allPurchaseDates.values.last.toString(): customerInfo.allPurchaseDates.values.first.toString() ;
      } on PlatformException catch (e) {
        AirFryrErrorHandling.surfacePlatformError(e);
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
      AirFryrErrorHandling.handlePurchaseError(e);
    }
    return restoreSuccess ?? false;
  }

  //checkEntitlements should only be called for a user that holds a pro app - its purpose is to validate that the pro sub is still valid
  static checkEntitlements() async {
    bool? entitlementValid = true;

    try {
      print("Getting customer info");
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      print("Checking entitlement is valid");
      entitlementValid = customerInfo.entitlements.all["AIr Fryr Pro"]?.isActive ;
      print("Status: $entitlementValid");
      FryerPreferences.setLastEntitlementCheckDate(DateTime.now());
    } on PlatformException catch (e) {
      //AirFryrErrorHandling.handlePurchaseError(e);
    }
    //If the entitlement check shows the entitlement is not valid, remove pro status
    if(!(entitlementValid ?? true)){
      final fryerController = Get.put(FryerController());
      fryerController.revertPurchaseStatus();

    }
  }

  static showSuccessDialog(){
    Get.defaultDialog(
        title: "Payment Successful",
        middleText: "Thank you for supporting Air Fryr!\n"
            "Your contribution helps me to keep the app going and is really appreciated.\n\n"
            "Got any feedback or ideas for improvement? Please leave an app review or drop me an email!"

    );
  }
}