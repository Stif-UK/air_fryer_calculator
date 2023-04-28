import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class VersionHistoryCopy{

  static Widget getLatestVersionCopy(){
    return Markdown(
      physics: ScrollPhysics(),
        data: "### v1.3.0\n"
        "* Added ability to filter the notebook by category\n"
        "* Implemented 'what's new' pop-up when updated\n\n"
        " --- \n\n"
            "Enjoying Air Fryr? If you find the app useful please consider supporting it's continued development. \n\n"
            "See 'Remove Ads' in the sidebar menu for more information"
        );
  }

  static Widget getFullVersionHistory(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Markdown(
          data: "## Latest Version:\n"
              "### v1.2.0\n"
              "* Added the ability to support the app and remove ads via in-app purchase\n"
              "* Updates to sidebar menu\n"
              " --- \n"
              "## Previous Releases:\n"
              "### v1.1.0\n"
              "* Added ability to search notebook\n"
              "* Added options to leave app reviews\n"
              "* Updated validation on note fields\n"
              "* Additional performance enhancements\n"
              " --- \n"
              "### v1.0.0\n"
              "* Calculate reduced cooking temperature & time for Air Frying\n"
              "* Switch preference between Celsius and Fahrenheit\n"
              "* Save notes for future reference\n"
              "* Edit saved notes"


      ),

    );
  }
}