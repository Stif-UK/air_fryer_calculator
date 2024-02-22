import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';
import 'package:air_fryer_calculator/ui/note_listtile.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AirFryerNotes extends StatefulWidget {
  AirFryerNotes({Key? key}) : super(key: key);
  final fryerController = Get.put(FryerController());

  @override
  State<AirFryerNotes> createState() => _AirFryerNotesState();
}

class _AirFryerNotesState extends State<AirFryerNotes> {
  final items = CategoryEnum.values;
  CategoryEnum? value = CategoryEnum.all;
  bool showFavourites = false;

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

  final Box<Notes> notebook = DataBaseHelper.getNotes();


  @override
  Widget build(BuildContext context) {

    //List to check if the notebook is 'empty'
    List<Notes> nonArchivedNotesList = notebook.values.where((note) => note.isArchived != true).toList();

    return  Column(
      children: [
        //Insert Ad into Widget Tree
        widget.fryerController.isAppPro.value || widget.fryerController.isDrawerOpen.value? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),

        Expanded(
          child: ValueListenableBuilder<Box<Notes>>(
            valueListenable: notebook.listenable(),
            builder: (context, box, _){
              //List to display
              List<Notes> filteredList = DataBaseHelper.getNotesByCategory(value!, showFavourites);
              // List<Notes> filteredList = notebook.values.where((note) => note.isArchived != true).toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:  Border.all(
                            width: 3.0,
                            color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                      child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Category Filter:",
                              style: Theme.of(context).textTheme.bodyLarge,),
                            DropdownButton<CategoryEnum>(
                              items: items.map(buildMenuItem).toList(),
                              value: value,
                              onChanged: (value){
                                setState(() {
                                  this.value = value;
                                });
                              },),
                            TextHelper.getCategoryIcon(value!)

                          ]

                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Favourites:",style: Theme.of(context).textTheme.bodyLarge,),
                      )),
                      showFavourites? Text("Showing favourites"): Text("Showing all"),
                      Switch(value: showFavourites, onChanged: (fav){
                        setState(() {
                          showFavourites = fav;
                        });
                      })
                    ],
                  ),
                  Divider(thickness: 2,),
                  filteredList.isEmpty?
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Icon(Icons.note_alt_outlined),
                                nonArchivedNotesList.isEmpty? const Text("Your Notebook is currently empty"): const Text("Nothing to show for the current filter"),
                              ],
                            ),
                          ),
                        ):
                      //If the notebook is not empty, we build the listview
                  Expanded(
                    child: ListView.separated(
                    itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index){
                        var note = filteredList.elementAt(index);
                        String key = note.toString();
                        String _title = note!.title;
                        String _category = note!.category;
                        double _temp = note!.temperature;
                        double _time = note!.time;
                        bool _isCelcius = note!.isCelcius;
                        bool _isArchived = note!.isArchived ?? false;

                        return Dismissible(
                          key: Key(key),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction){
                            setState(() async {
                              note.isArchived = true;
                              await note.save();
                              // Then show a snackbar?

                            });
                          },
                        // Show a red background as the item is swiped away.
                        background: Container(
                        alignment: Alignment.center,color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                              child: Text("Deleting",
                              style: Theme.of(context).textTheme.bodyLarge,),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                              child: Icon(Icons.delete_outline),
                            )
                          ],
                        ),),
                          child: NoteListtile(currentNote: note)


                        );
                      },
                      separatorBuilder: (context, index){
                        return const Divider(thickness: 2,);
                      },
                      ),)
                ],
              );

            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<CategoryEnum> buildMenuItem(CategoryEnum item) => DropdownMenuItem(
    value: item,
    child: Text(
      TextHelper.getCategoryText(item),
      style: Theme.of(context).textTheme.bodyLarge,
    )

  );


}