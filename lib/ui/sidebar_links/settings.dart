import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/controller/LanguageController.dart';
import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/flag_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({super.key});
  final fryerController = Get.put(FryerController());
  final languageController = Get.put(LanguageController());

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  BannerAd? banner;
  bool purchaseStatus = FryerPreferences.getAppPurchasedStatus() ?? false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!purchaseStatus)
    {
      final adState = Provider.of<AdState>(context);
      adState.initialization.then((status) {
        setState(() {
          banner = BannerAd(
              adUnitId: AdUnits.settingsAdUnitID,
              //If the device screen is large enough display a larger ad on this screen
              size: AdSize.banner,
              request: const AdRequest(),
              listener: adState.adListener)
            ..load();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {


      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(AppLocalizations.of(context)!.english),
        ),value: "en"),
        DropdownMenuItem(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(AppLocalizations.of(context)!.dutch),
        ),value: "nl"),
        DropdownMenuItem(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(AppLocalizations.of(context)!.danish),
        ),value: "da"),

      ];


    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(()=> SwitchListTile(
                    title: widget.fryerController.tempIsCelsius.value? Text(AppLocalizations.of(context)!.tempCelsius): Text(AppLocalizations.of(context)!.tempFahrenheit),
                    value: widget.fryerController.tempIsCelsius.value,
                    onChanged: (bool newValue) async{
                      widget.fryerController.updateTempPreference(newValue);
                    },

                  ),
                ),
                const Divider(thickness: 2,),
                Obx(()=> ListTile(
                    title: Text("${AppLocalizations.of(context)!.language}:"),
                    trailing: DropdownButton(
                      icon: FlagHelper.getFlag(widget.languageController.locale.value),
                      value: widget.languageController.locale.value.languageCode,
                      items: menuItems,
                      onChanged: (newValue){
                        widget.languageController.updateLocalePref(Locale(newValue!));
                      }



                    ),
                  ),
                ),
                const Divider(thickness: 2,)

              ],
            ),
          ),
          purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildRectangleSpace(banner, context),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
