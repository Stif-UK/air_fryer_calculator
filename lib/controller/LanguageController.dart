import 'package:get/get.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';

class LanguageController extends GetxController{
  final locale = FryerPreferences.getLocalePreference().obs;

  updateLocalePref(String value){
    FryerPreferences.setLocalePreference(value);
    locale(value);
  }


}
