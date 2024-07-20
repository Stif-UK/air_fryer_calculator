import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TextHelper{
  static getCategoryText(CategoryEnum category, BuildContext context){
    String returnText = "";

    switch (category){
      case CategoryEnum.sides:
        returnText = AppLocalizations.of(context)!.sides;
        break;
      case CategoryEnum.meat:
        returnText = AppLocalizations.of(context)!.meat;
        break;
      case CategoryEnum.seafood:
        returnText = AppLocalizations.of(context)!.seafood;
        break;
      case CategoryEnum.poultry:
        returnText = AppLocalizations.of(context)!.poultry;
        break;
      case CategoryEnum.vegetarian:
        returnText = AppLocalizations.of(context)!.vegetarian;
        break;
      case CategoryEnum.dessert:
        returnText = AppLocalizations.of(context)!.dessert;
        break;
      case CategoryEnum.other:
        returnText = AppLocalizations.of(context)!.other;
        break;
      case CategoryEnum.vegan:
        returnText = AppLocalizations.of(context)!.vegan;
        break;
      case CategoryEnum.baking:
        returnText = AppLocalizations.of(context)!.baking;
        break;
      case CategoryEnum.all:
        returnText = AppLocalizations.of(context)!.showAll;
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
      case CategoryEnum.baking:
        returnIcon = const Icon(FontAwesomeIcons.breadSlice);
        break;
      case CategoryEnum.all:
        returnIcon = const Icon(FontAwesomeIcons.filterCircleXmark);
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
      case "CategoryEnum.baking":
        returnEnum = CategoryEnum.baking;
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

  static String formatDate(DateTime date){
    final DateFormat formatter = DateFormat('yMMMd');
    String returnString = formatter.format(date);
    return returnString;
  }

}