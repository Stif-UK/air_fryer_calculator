import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../provider/adstate.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  //Setup Ads
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
              adUnitId: AdUnits.addNoteBannerAdUnitId,
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

  //Instance Variables
  late int temperature = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Note"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    _buildTitleInputRow(),
                    const Divider(thickness: 2,),
                    _buildTemperatureInputRow(temperature),
                  ],
                ),
              )
          ),


        ],
      ),
    );
  }

  Widget _buildTitleInputRow(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text("Title:",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.left,),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).focusColor),
                    borderRadius: BorderRadius.circular(50.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(50.0)
                )

            ),

          ),
        ),
      ],
    );
  }

  Widget _buildTemperatureInputRow(int temperature){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Text("Temperature:",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.left,),
        ),
    Slider(
    value: temperature.toDouble(),
    min: 150,
    max: 400,
    onChanged: (double value) {
    setState(()
    => temperature = value.toInt());
    },
    divisions: 25,
    label: "${temperature.toInt()}°C"

    //"${temperature.toInt()}${getTempSuffix(widget.fryerController.tempIsCelcius.value)}",),
        ),
      ],
    );
  }


}

