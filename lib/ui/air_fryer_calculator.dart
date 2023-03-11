import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../model/adUnits.dart';
import '../provider/adstate.dart';

class AirFryerCalculator extends StatefulWidget {
  AirFryerCalculator({Key? key}) : super(key: key);
  final fryerController = Get.put(FryerController());

  @override
  State<AirFryerCalculator> createState() => _AirFryerCalculatorState();
}

class _AirFryerCalculatorState extends State<AirFryerCalculator> {
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
              adUnitId: AdUnits.calculatorBannerAdUnitId,
              //adUnitId: WristCheckConfig.prodBuild == false? adState.getTestAds : AdUnits.viewWatchBannerAdUnitId,
              //If the device screen is large enough display a larger ad on this screen
              size: AdSize.banner,
              request: const AdRequest(),
              listener: adState.adListener)
            ..load();
        });
      });
    }
  }

  //Set the default slider values
  double temperature = 200;
  double time = 40;



  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Column(
        children: [
          //insert ad into Widget Tree
          purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Oven Temperature: ${temperature.toInt()}${getTempSuffix(widget.fryerController.tempIsCelcius.value)}",
                  style: Theme.of(context).textTheme.bodyMedium,),
                  Slider(
                    value: temperature,
                    min: 150,
                    max: 350,
                    onChanged: (double value) {
                      setState(()
                        => temperature = value);
                      },
                  divisions: 20,
                  label: "${temperature.toInt()}${getTempSuffix(widget.fryerController.tempIsCelcius.value)}",),
                  //Text("${temperature.toInt()}°C"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,25),
                    child: Text("Oven Time: ${time.toInt()} minutes",
                    style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  Slider(
                    value: time,
                    min: 0,
                    max: 180,
                    onChanged: (double value) {
                      setState(()
                      => time = value);
                    },
                    divisions: 36,
                    label: "${time.toInt()} mins",),
                  //Text("${time.toInt()} minutes")
                  const Divider(thickness: 2,),
                  //Display the output
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Suggested Air Fryer Setting",style: Theme.of(context).textTheme.bodyLarge,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Temperature: ${calculateAFTemp(widget.fryerController.tempIsCelcius.value, temperature)}${getTempSuffix(widget.fryerController.tempIsCelcius.value)}",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Time:\n ${(time * 0.8).toInt()} minutes",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,),
                  ),

                ]
              ),
            ),
          ),
          // //insert ad into Widget Tree
          // purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
        ],
      ),
    );
  }
}

String getTempSuffix(bool? isCelcius){
  isCelcius ??= true;
  return isCelcius? "°C" : "°F";
}

int calculateAFTemp(bool? isCelcius, double temperature){
  isCelcius ??= true;
  return isCelcius? temperature.toInt() - 20 : temperature.toInt() - 35;

}


