import 'package:air_fryer_calculator/errors/error_handling.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FryerController extends GetxController{
  //Manage temperature scale preference
  final tempIsCelcius = FryerPreferences.getTemperaturePreference()!.obs;

  updateTempPreference(bool tempPref) async {
    tempIsCelcius(tempPref);
    await FryerPreferences.setTemperaturePreference(tempPref);
  }

  //Manage app purchase status
  final isAppPro = FryerPreferences.getAppPurchasedStatus()!.obs;

  //Calling updateAppPurchaseStatus triggers a call to the Purchases package which will update the app status
  //based on whether the user holds the Air Fryr Pro entitlement.
  updateAppPurchaseStatus() async {
    bool? isPro = false;
    try {
      print("Trying to check purchase status");
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      isPro = customerInfo.entitlements.all["AIr Fryr Pro"]?.isActive ;
      print("Entitlement checked value: $isPro");
    } on PlatformException catch (e) {
      AirFryrErrorHandling.surfacePlatformError(e);
    }
    isAppPro(isPro);
    await FryerPreferences.setAppPurchasedStatus(isPro!);
  }

  revertPurchaseStatus() async{
    isAppPro(false);
    await FryerPreferences.setAppPurchasedStatus(false);

  }
}