import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagHelper{

  static Widget? getFlag(Locale loc){
    var language = loc.languageCode;
    double dimension = 24.0;

    switch(language) {
      case "en":
        return SvgPicture.asset(
    "assets/flags/GB.svg",
    width: dimension,
    height: dimension,
    );
      case "nl":
        return SvgPicture.asset(
          "assets/flags/NL.svg",
          width: dimension,
          height: dimension,
        );
      case "da":
        return SvgPicture.asset(
          "assets/flags/DA.svg",
          width: dimension,
          height: dimension,
        );
      default: return null;

    }

  }
}