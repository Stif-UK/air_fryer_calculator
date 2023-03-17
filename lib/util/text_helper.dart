import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:flutter/material.dart';

class TextHelper{
  static getCategoryText(CategoryEnum category){
    String returnText = "";

    switch (category){
      case CategoryEnum.sides:
        returnText = "Sides";
        break;
      case CategoryEnum.meat:
        returnText = "Meat";
        break;
      case CategoryEnum.seafood:
        returnText = "Seafood";
        break;
      case CategoryEnum.poultry:
        returnText = "Poultry";
        break;
      case CategoryEnum.vegetarian:
        returnText = "Vegetarian";
        break;
      case CategoryEnum.dessert:
        returnText = "Dessert";
        break;
      case CategoryEnum.other:
        returnText = "Other";
        break;
      case CategoryEnum.vegan:
        returnText = "Vegan";
        break;
    }
    return returnText;
  }

}