import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AirFryerNotes extends StatefulWidget {
  const AirFryerNotes({Key? key}) : super(key: key);

  @override
  State<AirFryerNotes> createState() => _AirFryerNotesState();
}

class _AirFryerNotesState extends State<AirFryerNotes> {
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
              adUnitId: AdUnits.notebookBannerAdUnitId,
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

    Box<Notes> notebook = DataBaseHelper.getNotes();

    return  Column(
      children: [
        //Insert Ad into Widget Tree
        purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),

        Expanded(
          //Check if the database is empty
          child: notebook.isEmpty?
              //if it is display a message
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.note_alt_outlined),
                Text("Your Notebook is currently empty"),
              ],
            ),
          )
              //if not empty, display the listview
              :
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You have ${notebook.length} entries in your notebook!")
                  ],
                )
              )
        ),
      ],
    );
  }
}