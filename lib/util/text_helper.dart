import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  static Icon getCategoryIcon(CategoryEnum category){
    Icon returnIcon = const Icon(FontAwesomeIcons.bowlFood);

    switch (category){
      case CategoryEnum.sides:
        returnIcon = const Icon(FontAwesomeIcons.bowlFood);
        break;
      case CategoryEnum.meat:
        returnIcon = const Icon(FontAwesomeIcons.burger);
        break;
      case CategoryEnum.seafood:
        returnIcon = const Icon(FontAwesomeIcons.fish);
        break;
      case CategoryEnum.poultry:
        returnIcon = const Icon(FontAwesomeIcons.drumstickBite);
        break;
      case CategoryEnum.vegetarian:
        returnIcon = const Icon(FontAwesomeIcons.carrot);
        break;
      case CategoryEnum.dessert:
        returnIcon = const Icon(FontAwesomeIcons.iceCream);
        break;
      case CategoryEnum.other:
        returnIcon = const Icon(FontAwesomeIcons.pizzaSlice);
        break;
      case CategoryEnum.vegan:
        returnIcon = const Icon(FontAwesomeIcons.plateWheat);
        break;
    }
    return returnIcon;
  }

  static String getTempSuffix(bool? isCelcius){
    isCelcius ??= true;
    return isCelcius? "°C" : "°F";
  }

  static CategoryEnum getEnumFromString(String enumString){
    CategoryEnum returnEnum = CategoryEnum.other;

    switch (enumString){
      case "CategoryEnum.sides":
        returnEnum = CategoryEnum.sides;
        break;
      case "CategoryEnum.meat":
        returnEnum = CategoryEnum.meat;
        break;
      case "CategoryEnum.seafood":
        returnEnum = CategoryEnum.seafood;
        break;
      case "CategoryEnum.poultry":
        returnEnum = CategoryEnum.poultry;
        break;
      case "CategoryEnum.vegetarian":
        returnEnum = CategoryEnum.vegetarian;
        break;
      case "CategoryEnum.dessert":
        returnEnum = CategoryEnum.dessert;
        break;
      case "CategoryEnum.other":
        returnEnum = CategoryEnum.other;
        break;
      case "CategoryEnum.vegan":
        returnEnum = CategoryEnum.vegan;
        break;
    }
    return returnEnum;

  }
}