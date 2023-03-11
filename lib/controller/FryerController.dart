import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FryerController extends GetxController{
  final tempIsCelcius = FryerPreferences.getTemperaturePreference().obs;

  updateTempPreference(bool tempPref) async {
    tempIsCelcius(tempPref);
    await FryerPreferences.setTemperaturePreference(tempPref);
  }
}