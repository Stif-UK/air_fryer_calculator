import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';
import 'package:air_fryer_calculator/ui/widgets/oven_settings.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
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

  
  @override
  Widget build(BuildContext context) {
    //Set first opened date on first app open
    if(FryerPreferences.getFirstUseDate() == null){
      FryerPreferences.setFirstUseDate(DateTime.now());
    }

    //Set default values on build??
    widget.fryerController.updateTemperature(200.0);
    widget.fryerController.updateTime(40);


    return Obx(() =>
      Column(
        children: [
          //insert ad into Widget Tree
          widget.fryerController.isAppPro.value || widget.fryerController.isDrawerOpen.value? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Oven Temperature",
                          content: OvenSettings(isTemp: true,),
                        );
                      },
                      child: Text("Oven Temperature: ${widget.fryerController.temperature.value.toInt()}${TextHelper.getTempSuffix(widget.fryerController.tempIsCelcius.value)}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Obx(() => Slider(
                      value: widget.fryerController.temperature.value,
                      max: 450,
                      onChanged: (double value) {
                        widget.fryerController.updateTemperature(value);
                        },
                    divisions: 90,
                    label: "${widget.fryerController.temperature.value.toInt()}${TextHelper.getTempSuffix(widget.fryerController.tempIsCelcius.value)}",),
                  ),
                  //Text("${temperature.toInt()}°C"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,25),
                    child: ElevatedButton(
                      child: Text("Oven Time: ${widget.fryerController.cooktime.toInt()} minutes",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Oven Time",
                          content: OvenSettings(isTemp: false,),
                        );
                      },
                    ),
                  ),
                  Slider(
                    value: widget.fryerController.cooktime.value,
                    min: 0,
                    max: 180,
                    onChanged: (double value) {
                      widget.fryerController.updateTime(value);
                    },
                    divisions: 180,
                    label: "${widget.fryerController.cooktime.value.toInt()} mins",),
                  //Text("${time.toInt()} minutes")
                  const Divider(thickness: 2,),
                  //Display the output
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Suggested Air Fryer Setting",style: Theme.of(context).textTheme.bodyLarge,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Temperature: ${calculateAFTemp(widget.fryerController.tempIsCelcius.value, widget.fryerController.temperature.value)}${TextHelper.getTempSuffix(widget.fryerController.tempIsCelcius.value)}",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Time:\n ${calculateTime(widget.fryerController.cooktime.value).toInt()} minutes",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      child: const Text("Save to Notes"),
                      onPressed: (){
                        Get.to(() => AddNotes(
                          time: calculateTime(widget.fryerController.cooktime.value),
                        temperature: calculateAFTemp(widget.fryerController.tempIsCelcius.value, widget.fryerController.temperature.value).toDouble()
                          ,));
                      },
                    ),
                  )

                ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}


int calculateAFTemp(bool? isCelcius, double temperature){
  isCelcius ??= true;
  int returnValue = isCelcius? temperature.toInt() - 20 : temperature.toInt() - 35;
  return returnValue > 0? returnValue : 0;

}

double calculateTime(double ovenTime){
  return (ovenTime * 0.8);
}


