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
                  child: Text("Temperature Guide",
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
                    Text("Beef", style: Theme.of(context).textTheme.headlineSmall,),
                    Text("rare: ${fryerController.tempIsCelsius.value == true? "60": "140"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                    Text("medium: ${fryerController.tempIsCelsius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                    Text("well done: ${fryerController.tempIsCelsius.value == true? "77": "170"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}")
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
                        Text("Pork", style: Theme.of(context).textTheme.headlineSmall,),
                        Text(""),
                        Text("temp: ${fryerController.tempIsCelsius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
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
                        Text("Poultry", style: Theme.of(context).textTheme.headlineSmall,),
                        Text("pieces: ${fryerController.tempIsCelsius.value == true? "74": "165"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("whole: ${fryerController.tempIsCelsius.value == true? "85": "185"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
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
                        Text("Fish", style: Theme.of(context).textTheme.headlineSmall,),
                        Text(""),
                        Text("temp: ${fryerController.tempIsCelsius.value == true? "58": "137"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
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
                        Text("Baking", style: Theme.of(context).textTheme.headlineSmall,),
                        Text("cake: ${fryerController.tempIsCelsius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("bread: ${fryerController.tempIsCelsius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
                        Text("brownies: ${fryerController.tempIsCelsius.value == true? "88": "190"}${TextHelper.getTempSuffix(fryerController.tempIsCelsius.value)}"),
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

