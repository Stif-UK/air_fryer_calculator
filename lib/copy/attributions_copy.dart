import 'package:flutter/material.dart';

class AttributionsCopy{


  static Widget getAttributionFontAwesome(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text("This app makes use of FontAwesome, using the font_awesome_flutter library. More information is available at fontawesome.com"
          "\nDistributed under the MIT Licence."
      ),
    );
  }

  static Widget getAttributionHive(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text("Hive has been utilised to provide the database underpinning the application."
          "\nAvailable at pub.dev/packages/hive \n"
          "Distributed under the Apache 2.0 Licence."
      ),
    );
  }

  static Widget getAttributionGetX(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text("GetX has been used for state management and page routing. "
          "\nAvailable at pub.dev/packages/get \n"
          "Distributed under the MIT Licence."),
    );
  }

  static Widget getAttributionFlutterIcons(){
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text( "The app icon makes use of an icon created by 'imaginationlol', found on flaticon"
          "\nAvailable at https://www.flaticon.com/free-icons/air-fryer"
          "\n\nThe easyappicon tool was used to generate icons - available at easyappicon.com"
          "\n\nThe flutter_launcher_icons package has been used to simplify deployment of icons"
      "\nAvailable at pub.dev/packages/flutter_launcher_icons"
          "\nDistributed under the MIT Licence."
          ""
      ),
    );
  }




}