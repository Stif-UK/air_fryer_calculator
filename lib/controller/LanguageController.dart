import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';

class LanguageController extends GetxController{
  final locale = Locale(FryerPreferences.getLocalePreference()).obs;
  
  updateLocalePref(Locale value){
    FryerPreferences.setLocalePreference(value.toString());
    locale(value);
  }


}
