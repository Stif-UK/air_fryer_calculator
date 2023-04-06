import 'package:flutter/material.dart';

class RemoveAdsCopy{
  static getRemoveAdsMainCopy(BuildContext context){
    return Text(
      "I build little apps for fun, and provide them completely free, with ads displayed to help me cover the development fees."
          "\n\nHowever if you would like to support the app development and remove ads, you can click below to see in-app purchase "
          "options."
          "\n\nPaying doesn't unlock any additional functionality (everything is free!) it simply removes ads and hopefully gives you a warm feeling that you're"
          " supporting someone that finds their fun creating little apps that others can (hopefully) enjoy!",
    style: Theme.of(context).textTheme.bodyLarge,);
  }

  static getRemoveAdsSheetCopy(BuildContext context){
    return Text("All options will remove ads, however options are available to allow you to choose how much you would like to pay to support!",
    style: Theme.of(context).textTheme.bodyLarge,
    textAlign: TextAlign.center,);
  }

  static getButtonLabel(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Show Payment Options"),
    );
  }
}