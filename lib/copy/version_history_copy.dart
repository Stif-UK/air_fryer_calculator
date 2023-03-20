import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class VersionHistoryCopy{

  static Widget getFullVersionHistory(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Markdown(
          data: "**Latest Version: v1.0.0**\n\n"
              "* Calculate reduced cooking temperature & time for Air Frying\n"
              "* Switch preference between Celsius and Fahrenheit\n"
              "* Save notes for future reference\n\n"


      ),

    );
  }
}