import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/copy/dialogs.dart';
import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:air_fryer_calculator/l10n/app_localizations.dart';


class AirFryerTemperature extends StatefulWidget {
  AirFryerTemperature({Key? key}) : super(key: key);

  @override
  State<AirFryerTemperature> createState() => _AirFryerTemperatureState();
}

class _AirFryerTemperatureState extends State<AirFryerTemperature> {
  final fryerController = Get.put(FryerController());

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
              adUnitId: AdUnits.temperatureBannerAdUnitId,
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
    return SingleChildScrollView(
      child: Obx( () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            fryerController.isAppPro.value || fryerController.isDrawerOpen.value? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(AppLocalizations.of(context)!.tempGuide,
                  style: Theme.of(context).textTheme.headlineMedium,),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.circleQuestion),
                    onPressed: (){
                      Dialogs.getTemperatureHelpDialog();
                    })
              ],
            ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.cow, size: 50,))),
              Expanded(
                flex: 5,
                child: Obx(() => Column(
                  children: [
                    Text(AppLocalizations.of(context)!.beef, style: Theme.of(context).textTheme.headlineSmall,),
                    Text("${AppLocalizations.of(context)!.rare}: ${fryerController.tempIsCelsius.value == true? "60": "140"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                    Text("${AppLocalizations.of(context)!.medium}: ${fryerController.tempIsCelsius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                    Text("${AppLocalizations.of(context)!.wellDone}: ${fryerController.tempIsCelsius.value == true? "77": "170"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}")
                  ],

                )),
              )
            ],
          ),
            const Divider(thickness: 2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Obx(() => Column(
                      children: [
                        Text(AppLocalizations.of(context)!.pork, style: Theme.of(context).textTheme.headlineSmall,),
                        Text(""),
                        Text("${AppLocalizations.of(context)!.temperature}: ${fryerController.tempIsCelsius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text(""),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.bacon, size: 50,))),
              ],
            ),
            const Divider(thickness: 2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.drumstickBite, size: 50,))),
                Expanded(
                  flex: 5,
                  child: Obx(()=> Column(
                      children: [
                        Text(AppLocalizations.of(context)!.poultry, style: Theme.of(context).textTheme.headlineSmall,),
                        Text("${AppLocalizations.of(context)!.pieces}: ${fryerController.tempIsCelsius.value == true? "74": "165"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("${AppLocalizations.of(context)!.whole}: ${fryerController.tempIsCelsius.value == true? "85": "185"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text(""),
                      ],

                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Obx(() => Column(
                      children: [
                        Text(AppLocalizations.of(context)!.fish, style: Theme.of(context).textTheme.headlineSmall,),
                        Text(""),
                        Text("${AppLocalizations.of(context)!.temperature}: ${fryerController.tempIsCelsius.value == true? "58": "137"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text(""),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.fish, size: 50,))),
              ],
            ),
            const Divider(thickness: 2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.cakeCandles, size: 50,))),
                Expanded(
                  flex: 5,
                  child: Obx(() => Column(
                      children: [
                        Text(AppLocalizations.of(context)!.baking, style: Theme.of(context).textTheme.headlineSmall,),
                        Text("${AppLocalizations.of(context)!.cake}: ${fryerController.tempIsCelsius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("${AppLocalizations.of(context)!.bread}: ${fryerController.tempIsCelsius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("${AppLocalizations.of(context)!.brownies}: ${fryerController.tempIsCelsius.value == true? "88": "190"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                      ],

                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2,),




          ],
        ),
      ),
    );
  }
}

