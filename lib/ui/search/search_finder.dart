import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/ui/note_listtile.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';



class SearchFinder extends StatefulWidget {
  final String query;

  const SearchFinder({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchFinder> createState() => _SearchFinderState();
}

class _SearchFinderState extends State<SearchFinder> {

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
              adUnitId: AdUnits.searchUIBannerAdUnitId,
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
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: Hive.box<Notes>('NoteBook').listenable(),
              builder:
                  (context, Box<Notes> noteBook,_){
                var results = widget.query.isEmpty
                    ? noteBook.values.where((note) => note.isArchived == false).toList() //whole list
                    : noteBook.values.where((note) => note.title.toLowerCase().contains(widget.query) && note.isArchived == false).toList();

                return results.isEmpty
                //if there are no results, return 'no results' page
                    ? const Center(
                  child: Text('No results found',),
                )
                    : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: results.length,
                    itemBuilder: (context, index){
                      //passing as a custom list
                      final Notes note = results[index];

                      return NoteListtile(currentNote: note);

                   }

                );
              }
          ),
        ),
        //insert ad
        purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
        const SizedBox(height: 50,)
      ],
    );
  }
}
