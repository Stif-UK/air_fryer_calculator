import 'package:air_fryer_calculator/copy/dialogs.dart';
import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../model/fryer_preferences.dart';

class DeletedNotes extends StatefulWidget {
  const DeletedNotes({Key? key}) : super(key: key);

  @override
  State<DeletedNotes> createState() => _DeletedNotesState();
}

class _DeletedNotesState extends State<DeletedNotes> {
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
              adUnitId: AdUnits.deletedNotesBannerAdUnitId,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deleted Notes"),
        actions: [
          IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: (){
                Dialogs.getHelpDialog(context);
              } )
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<Notes>>(
                valueListenable: notebook.listenable(),
                builder: (context, box, _){
                  List<Notes> archiveList = DataBaseHelper.getArchivedNotes();



                  return archiveList.isEmpty?Container(
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("When you delete a note from the main notebook it will appear here.\n\n"
                          "You can then choose to fully delete by swiping away or restore to the notebook by selecting the note.",
                        textAlign: TextAlign.center,),
                    ),
                  ):

                  ListView.separated(
                    itemCount: archiveList.length,
                    itemBuilder: (BuildContext context, int index){
                      final item = archiveList[index].toString();
                      var note = archiveList.elementAt(index);
                      String? _title = note.title;
                      String? _category = TextHelper.getCategoryText(TextHelper.getEnumFromString(note.category));


                      return Dismissible(
                        key: Key(item),
                        direction: DismissDirection.horizontal,

                        onDismissed: (direction) {
                          //if swipe left
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              //Remove from the view and remove from the database
                              archiveList.removeAt(index);
                              notebook.delete(note.key);
                            });
                          }
                          if(direction == DismissDirection.startToEnd){
                            var currentNote = notebook.getAt(note.key);
                            setState(() {
                              archiveList.removeAt(index);
                              currentNote!.isArchived = false;
                              currentNote.save();

                            });
                          }

                        },

                        background: Container(
                          alignment: Alignment.center,color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                                child: Text("Restoring Note",
                                  style: Theme.of(context).textTheme.bodyLarge,),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                child: Icon(Icons.restore),
                              )
                            ],
                          ),),
                        secondaryBackground: Container(
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

                        child: ListTile(
                          leading: TextHelper.getCategoryIcon(TextHelper.getEnumFromString(note.category)),
                          title: Text(_title),
                          onLongPress: (){
                            setState(() {
                              note.isArchived == false;
                            });
                          },

                          //onTap: () => Get.to(() => ViewWatch(currentWatch: watch,)),
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return const Divider(thickness: 2,);
                    },
                  );
                }


            ),
          ),
          purchaseStatus? const SizedBox(height: 0,) : AdWidgetHelper.buildLargeAdSpace(banner, context),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
