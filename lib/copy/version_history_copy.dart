import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';

class VersionHistoryCopy{

  static Widget getLatestVersionCopy(){
    return Markdown(
      physics: ScrollPhysics(),
        data: _composeVersionCopy()

        // "### v1.3.0\n"
        // "* Added ability to filter the notebook by category\n"
        // "* Implemented 'what's new' pop-up when updated\n\n"
        // " --- \n\n"
        //     "Enjoying Air Fryr? If you find the app useful please consider supporting it's continued development. \n\n"
        //     "See 'Remove Ads' in the sidebar menu for more information"
        );
  }

  static String _composeVersionCopy(){
    bool isPro = FryerPreferences.getAppPurchasedStatus() ?? false;
    String latestVersion = "### v1.5.1\n"
        "* Implemented GDPR pop-up dialog for European users\n"
        "* Implemented privacy settings selection for all users via sidebar\n"
        " --- \n\n";

    String proFooter = "Thank you for Supporting Air Fryr - your donation helps keep the app alive!";

    String baseFooter = "Enjoying Air Fryr? If you find the app useful please consider supporting it's continued development. \n\n"
        "See 'Remove Ads' in the sidebar menu for more information";

    String footer = isPro? proFooter : baseFooter;

    return latestVersion + footer;

  }

  static Widget getFullVersionHistory(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Markdown(
          data: "## Latest Version:\n"
              "### v1.5.1\n"
              "* Implemented GDPR pop-up dialog for European users\n"
              "* Implemented privacy settings selection for all users via sidebar\n"
              " --- \n\n"
          "## Previous Releases:\n"
              "### v1.5.0\n"
              "* Added temperature reference information\n"
              "* Introduced a first use demo\n"
              "* Improved readability of notes\n"
              " --- \n\n"
              "### v1.4.0\n"
              "* Added the ability to mark notes as favourites\n"
              "* Implemented ability to filter notes by favourites\n"
              "* Made temperature selector on calculator more granular\n"
              "* Increased maximum length of note that can be displayed\n"
              "* Updated Google Admob SDK to latest version\n"
              "* Updated Revenuecat SDK to latest version\n"
              "* Updated target operating system versions\n"
              " --- \n"
              "### v1.3.0\n"
              "* Added ability to filter the notebook by category\n"
              "* Implemented 'what's new' pop-up when updated\n\n"
              " --- \n"

              "### v1.2.0\n"
              "* Added the ability to support the app and remove ads via in-app purchase\n"
              "* Updates to sidebar menu\n"
              " --- \n"

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