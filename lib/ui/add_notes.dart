import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/custom_form_field.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
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
  double maximumTemp = 450;
  double minimumTemp = 130;
  double maximumTime = 180;
  double minimumTime = 0;
  CategoryEnum _selectedValue = CategoryEnum.meat;



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
                      const CustomFormField(fieldTitle: "Title:",hintText: "Title"),
                      const Divider(thickness: 2,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Category:",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 3, color: Theme.of(context).focusColor),
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 3, color: Colors.lightBlue),
                                          borderRadius: BorderRadius.circular(20.0)
                                      )

                                  ),
                                  value: _selectedValue,
                                    items: <CategoryEnum>[CategoryEnum.sides, CategoryEnum.meat, CategoryEnum.poultry, CategoryEnum.seafood, CategoryEnum.vegetarian, CategoryEnum.vegan, CategoryEnum.dessert, CategoryEnum.other]
                                        .map<DropdownMenuItem<CategoryEnum>>((CategoryEnum value) {
                                      return DropdownMenuItem<CategoryEnum>(
                                        value: value,
                                        child: Text(
                                          TextHelper.getCategoryText(value),
                                          style: Theme.of(context).textTheme.bodyLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (CategoryEnum? value){
                                    setState(() {
                                      _selectedValue = value!;
                                    });
              }),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Icon(Icons.fastfood)),
                            ],
                          ),
                        ],
                      ),
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

                          //Increase temperature button
                          IconButton(onPressed: (){setState(() {
                            widget.temperature = increaseTemp(widget.temperature);
                          });
                          }, icon: const Icon(Icons.add_circle_outline)),
                          //Decrease temperature button
                          IconButton(onPressed: (){setState(() {
                            widget.temperature = decreaseTemp(widget.temperature);
                          });
                          }, icon: const Icon(Icons.remove_circle_outline)),

                        ],
                      ),
                      Slider(
                        value: widget.temperature,
                        min: minimumTemp,
                        max: maximumTemp,
                        onChanged: (double value) {
                          setState(()
                          => widget.temperature = value);
                        },
                        divisions: 64,
                        label: "${widget.temperature.toInt()} degrees",),
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
                                     widget.time = increaseTime(widget.time);
                                      });
                                      }, icon: const Icon(Icons.add_circle_outline)),
                          //Decrease time button
                          IconButton(onPressed: (){setState(() {
                            widget.time = decreaseTime(widget.time);
                          });
                          }, icon: const Icon(Icons.remove_circle_outline)),

                        ],
                      ),
                      Slider(
                        value: widget.time,
                        min: minimumTime,
                        max: maximumTime,
                        onChanged: (double value) {
                          setState(()
                          => widget.time = value);
                        },
                       label: "${widget.time.toInt()} mins",),
                      const Divider(thickness: 2,),
                      const CustomFormField(fieldTitle: "Notes:", hintText: "Enter Notes", minLines: 4, maxLines: 20,)
                    ],
                  ),
                ),
              )
          ),


        ],
      ),
    );
  }

//Increase Temperature by 5 degrees up to maximum
double increaseTemp(double currentTemp){
    double maxTemp = maximumTemp;
    double returnTemp = currentTemp + 5;
    return returnTemp < maxTemp? returnTemp : maxTemp;
}

//Decrease Temperature by 5 degrees down to minimum
  double decreaseTemp(double currentTemp){
    double minTemp = minimumTemp;
    double returnTemp = currentTemp - 5;
    return returnTemp > minTemp? returnTemp : minTemp;
  }

  //Increase Time by 5 minute up to maximum
  double increaseTime(double currentTime){
    double maxTime = maximumTime;
    double returnTime = currentTime + 5;
    return returnTime < maxTime? returnTime : maxTime;
  }

  //Decrease Time by 5 minute up to maximum
  double decreaseTime(double currentTime){
    double minTime = minimumTime;
    double returnTime = currentTime - 5;
    return returnTime > minTime? returnTime : minTime;
  }

}

