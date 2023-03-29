import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutAppCopy{

  static Widget getAboutAppCopy(){
    return const Padding(
        padding: EdgeInsets.all(12.0),
      child: Markdown(
        data: "**Air Fryr**\n\n"
            "Air Fryr is a little utility app I've put together to help me get the most out of my new Air Fryer.\n\n"
            "It provides a calculator function to convert cooking times from a standard oven to an air fryer, reducing the temperature and cooking time accordingly.\n\n"
            "The calculation itself should be considered a **guideline only** - you should always ensure food is properly cooked!\n\n"
            "All Air Fryers and ovens are different, so if you do find you need to add more time, or change the temperature, you can save your calculation for future reference. "
            "Saved notes can be edited and searched, so over time the app can become a reference to keep track of all the awesome dishes you cook!\n\n"
            "If you find the application useful (or even if you don't and just want to ask for extra features!) please consider leaving a review on the app store."


      ),

    );
  }
}