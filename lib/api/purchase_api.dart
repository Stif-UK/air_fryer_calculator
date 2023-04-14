import 'package:air_fryer_calculator/api/keys.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{
  static final _apiKey = AirFryrKeys.getRevenueCatKey();

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
}