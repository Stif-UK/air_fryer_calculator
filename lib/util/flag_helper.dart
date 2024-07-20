import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagHelper{

  static Widget? getFlag(Locale loc){
    var language = loc.languageCode;

    switch(language) {
      case "en":
        return SvgPicture.asset(
    "assets/flags/GB.svg",
    width: 24,
    height: 24,
    );
      case "nl":
        return SvgPicture.asset(
          "assets/flags/NL.svg",
          width: 24,
          height: 24,
        );
      default: return null;

    }

  }
}