import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RemoveAdsCopy{

  static getPageTitle(BuildContext context){
    return Text(AppLocalizations.of(context)!.removeAds);
  }

  static getPageTitleSupporter(BuildContext context){
    return Text(AppLocalizations.of(context)!.supportAirFryr);
  }

  static getRemoveAdsMainCopy(BuildContext context){
    return Text(
      "I build little apps for fun, and provide them completely free, with ads displayed to help me cover the development fees."
          "\n\nHowever if you would like to support the app development and remove ads, you can click below to see in-app purchase "
          "options."
          "\n\nPaying doesn't unlock any additional functionality (everything is free!) it simply removes ads and hopefully gives you a warm feeling that you're"
          " supporting someone that finds their fun creating little apps that others can (hopefully) enjoy!",
    style: Theme.of(context).textTheme.bodyLarge,);
  }

  static getSupporterMainCopy(BuildContext context){
    return Text(
      "Thank you for supporting Air Fryr!\n\n"
          "Your support means a lot and makes it possible for me to continue to develop Air Fryr and other apps like it.\n\n"
          "If you're enjoying the app please consider telling your friends about it or leave a review to let me know what you like about the app and what else you'd like to see added to it!\n\n"
          "If you'd like to continue to support Air Fryr additional donations can be made at any time.",
      style: Theme.of(context).textTheme.bodyLarge,);
  }



  static getButtonLabel(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(AppLocalizations.of(context)!.showPaymentOptions),
    );
  }

  static getButtonLabelSupporter(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(AppLocalizations.of(context)!.donateAgain),
    );
  }
}