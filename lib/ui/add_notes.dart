import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/custom_form_field.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_custom.dart';
import '../provider/adstate.dart';

class AddNotes extends StatefulWidget {
  AddNotes({
    Key? key,
    required this.time,
    required this.temperature
  }) : super(key: key);

  double time;
  double temperature;
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
  // int time = widget.time;

  //Form Key
  final _formKey = GlobalKey<FormState>();

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      //Title Row
                      CustomFormField(fieldTitle: "Title:",hintText: "Title"),
                      const Divider(thickness: 2,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Temperature: ${widget.temperature.toInt()} degrees",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge,),
                            ),
                          ),

                          //Increase time button
                          IconButton(onPressed: (){setState(() {
                            widget.temperature = widget.temperature + 5;
                          });
                          }, icon: const Icon(Icons.add_circle_outline)),
                          //Decrease time button
                          IconButton(onPressed: (){setState(() {
                            widget.temperature = widget.temperature - 5;
                          });
                          }, icon: const Icon(Icons.remove_circle_outline)),

                        ],
                      ),
                      const Divider(thickness: 2,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Time: ${widget.time.toInt()} minutes",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge,),
                            ),
                          ),

                          //Increase time button
                          IconButton(onPressed: (){setState(() {
                                     widget.time = widget.time + 1;
                                      });
                                      }, icon: const Icon(Icons.add_circle_outline)),
                          //Decrease time button
                          IconButton(onPressed: (){setState(() {
                            widget.time = widget.time - 1;
                          });
                          }, icon: const Icon(Icons.remove_circle_outline)),

                        ],
                      ),
                      Slider(
                        value: widget.time,
                        min: 0,
                        max: 180,
                        onChanged: (double value) {
                          setState(()
                          => widget.time = value);
                        },
                       label: "${widget.time.toInt()} mins",),
                      const Divider(thickness: 2,),
                      CustomFormField(fieldTitle: "Notes", hintText: "Enter Notes")
                    ],
                  ),
                ),
              )
          ),


        ],
      ),
    );
  }




}

