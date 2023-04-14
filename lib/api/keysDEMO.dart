import 'dart:io' show Platform;

class AirFryrKeys{
  static String getRevenueCatKey(){
    return Platform.isAndroid? "" : "";
  }
}