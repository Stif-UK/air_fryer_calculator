import 'package:air_fryer_calculator/errors/error_handling.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class FryerController extends GetxController{
  //Manage temperature scale preference
  final tempIsCelsius = FryerPreferences.getTemperaturePreference().obs;

  updateTempPreference(bool tempPref) async {
    tempIsCelsius(tempPref);
    await FryerPreferences.setTemperaturePreference(tempPref);
  }

  //calculation temperature and time
  final temperature = 200.0.obs;

  updateTemperature(double temp){
    temperature(temp);
  }

  final cookTime = 40.0.obs;

  updateTime(double time){
    cookTime(time);
  }

  //Status of navigation drawer
  final isDrawerOpen = false.obs;

  updateIsDrawerOpen(bool isOpen) {
    isDrawerOpen(isOpen);
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