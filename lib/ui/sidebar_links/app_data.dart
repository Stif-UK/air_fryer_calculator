import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/ui/app_data/restore.dart';
import 'package:air_fryer_calculator/ui/app_data/share_backup.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';


class AppData extends StatefulWidget {
  const AppData({super.key});

  @override
  State<AppData> createState() => _AppDataState();
}

class _AppDataState extends State<AppData> {
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
              adUnitId: AdUnits.appdataAdUnitID,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appData),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width)*0.8,
                    height: (MediaQuery.of(context).size.height)*0.15,
                    child: ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(AppLocalizations.of(context)!.backup,
                            style: Theme.of(context).textTheme.headlineLarge
                          ),
                        ),
                        onPressed: (){
                          Get.to(() => ShareBackup());
                        },
                        style: ButtonStyle(
                            backgroundColor: Get.isDarkMode? WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary) : WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.primary),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.black)
                                )

                            )
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width)*0.8,
                      height: (MediaQuery.of(context).size.height)*0.15,
                      child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(AppLocalizations.of(context)!.restore,
                              style: Theme.of(context).textTheme.headlineLarge
                            ),
                          ),
                          onPressed: (){
                            Get.to(() => const Restore());
                          },
                          style: ButtonStyle(
                              backgroundColor: Get.isDarkMode? WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary) : WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.primary),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(color: Colors.black)
                                  )

                              )
                          )
                      ),
                    ),
                  ),
                ],
              ),
          ),
          purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildRectangleSpace(banner, context),
          const SizedBox(height: 50,)
        ],
      ));
  }
}
