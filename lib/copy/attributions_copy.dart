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


}