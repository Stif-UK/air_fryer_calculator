import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:air_fryer_calculator/model/enums/note_enums.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/ui/custom_form_field.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:air_fryer_calculator/util/note_helper.dart';
import 'package:air_fryer_calculator/util/review_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../provider/adstate.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/util/string_extention.dart';

class AddNotes extends StatefulWidget {
  AddNotes({
    Key? key,
    required this.time,
    required this.temperature,
    this.currentNote
  }) : super(key: key);

  final fryerController = Get.put(FryerController());
  double time;
  double temperature;
  Notes? currentNote;
  //bool to confirm if note has been marked for editing
  bool inEditState = false;

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
  double minimumTemp = 0;
  double maximumTime = 180;
  double minimumTime = 0;
  CategoryEnum _selectedCategory = CategoryEnum.meat;
  String title = "";
  //isViewNote is true if a note object is passed in the constructor



  //Form Key
  final _formKey = GlobalKey<FormState>();
  //Text Controller
  final titleFieldController = TextEditingController();
  final notesFieldController = TextEditingController();

  @override
  void dispose(){
    //clean up the controller when the widget is disposed
    titleFieldController.dispose();
    notesFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NoteEnum noteState = NoteHelper.getNoteViewState(widget.currentNote, widget.inEditState);
    if(noteState!= NoteEnum.add){
      title = widget.currentNote!.title;
      _selectedCategory = TextHelper.getEnumFromString(widget.currentNote!.category);
      //Load note content, only if note is not being edited
      if(!widget.inEditState) {
        titleFieldController.value =
            TextEditingValue(text: widget.currentNote!.title);
        notesFieldController.value =
            TextEditingValue(text: widget.currentNote!.notes ?? "");
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: NoteHelper.getTitle(noteState, title),
        //title: _isViewNote? Text(widget.currentNote!.title): const Text("Save Note"),
      //Show edit button if a note object is loaded
        actions: NoteHelper.getNoteViewState(widget.currentNote, widget.inEditState) == NoteEnum.view? [Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              icon: const Icon(FontAwesomeIcons.edit),
              onPressed: (){
                setState(() {
                  widget.inEditState = true;
                });
              },

          ),
        )] : null,
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
                      CustomFormField(
                        enabled: noteState == NoteEnum.view? false: true,
                        fieldTitle: "Title:",
                        hintText: "Title",
                        maxLines: 1,
                        controller: titleFieldController,
                        textCapitalization: TextCapitalization.words,
                        validator: (String? val) {
                          if(!val!.isAlphaNumericAndNotEmpty) {
                            print(!val!.isAlphaNumericAndNotEmpty);
                            return 'Title missing or invalid characters included';
                          }
                        },
                      ),


                      noteState == NoteEnum.view? const SizedBox(height: 0,): const Divider(thickness: 2,),
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
                                child: noteState == NoteEnum.view?
                                    //if view only then just show text
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                  child: Text(TextHelper.getCategoryText(TextHelper.getEnumFromString(widget.currentNote!.category)),
                                  style: Theme.of(context).textTheme.bodyLarge,),
                                ):
                                    //else show dropdown
                                DropdownButtonFormField(
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
                                  value: _selectedCategory,
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
                                    noteState == NoteEnum.edit?
                                    setState(() {
                                      widget.currentNote!.category = value!.toString();
                                      widget.currentNote!.save();
                                    }):
                                    setState(() {
                                      _selectedCategory = value!;
                                    });
              }),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: TextHelper.getCategoryIcon(_selectedCategory)))
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
                              child: Text("Temperature: ${widget.temperature.toInt()} ${TextHelper.getTempSuffix(widget.fryerController.tempIsCelcius.value)}",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge,),
                            ),
                          ),
                          noteState == NoteEnum.view? const SizedBox(height: 0,): Row(
                            children: [

                              //Decrease temperature button
                              IconButton(onPressed: (){setState(() {
                                widget.temperature = decreaseTemp(widget.temperature);
                              });
                              }, icon: const Icon(Icons.remove_circle_outline)),
                              //Increase temperature button
                              IconButton(onPressed: (){setState(() {
                                widget.temperature = increaseTemp(widget.temperature);
                              });
                              }, icon: const Icon(Icons.add_circle_outline)),
                            ],
                          ),



                        ],
                      ),
                      noteState == NoteEnum.view? const SizedBox(height: 0,):Slider(
                        value: widget.temperature,
                        min: minimumTemp,
                        max: maximumTemp,
                        onChanged: (double value) {
                          setState(()
                          => widget.temperature = value);
                        },
                        divisions: 90,
                        label: "${widget.temperature.toInt()} ${TextHelper.getTempSuffix(widget.fryerController.tempIsCelcius.value)}",),
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


                          noteState == NoteEnum.view? const SizedBox(height: 0,) :Row(
                            children: [
                              //Decrease time button
                              IconButton(onPressed: (){setState(() {
                                widget.time = decreaseTime(widget.time);
                              });
                              }, icon: const Icon(Icons.remove_circle_outline)),
                              //Increase time button
                              IconButton(onPressed: (){setState(() {
                                widget.time = increaseTime(widget.time);
                              });
                              }, icon: const Icon(Icons.add_circle_outline)),
                            ],
                          ),


                        ],
                      ),
                      noteState == NoteEnum.view? const SizedBox(height: 0,): Slider(
                        value: widget.time,
                        min: minimumTime,
                        max: maximumTime,
                        onChanged: (double value) {
                          setState(()
                          => widget.time = value);
                        },
                       label: "${widget.time.toInt()} mins",),
                      const Divider(thickness: 2,),
                      CustomFormField(
                        enabled: noteState == NoteEnum.view? false: true,
                        fieldTitle: "Notes:",
                        hintText: "Enter Notes",
                        minLines: 4,
                        maxLines: 20,
                        controller: notesFieldController,
                        textCapitalization: TextCapitalization.sentences,),
                      //noteState == NoteEnum.view? const SizedBox(height: 0,): const Divider(thickness: 2,),
                      noteState == NoteEnum.view? showTagline(): const Divider(thickness: 2,),



                      //If page is to save a new note, show the save button
                      noteState == NoteEnum.add?Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              //Check that fields are valid
                              if(_formKey.currentState!.validate()) {
                            //Add a new object to the database, notify user and close the window
                            await DataBaseHelper.addNote(titleFieldController.text, _selectedCategory, widget.temperature, widget.time, notesFieldController.text, widget.fryerController.tempIsCelcius.value, false); //TODO: Update value of 'favourite'
                            Get.back();
                            title = titleFieldController.text;
                            Get.snackbar(
                                "$title added to notebook",
                                "Your notebook has been updated",
                            snackPosition: SnackPosition.BOTTOM,
                            icon: TextHelper.getCategoryIcon(_selectedCategory));

                            //Check if user should be prompted to review app
                            ReviewHelper.shouldPromptReview();


                              }
                        },
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.save),
                            ),
                            Text("Save Note"),
                          ],
                        )
                        ),
                      ): const SizedBox(height: 0,),

                      //If page is to edit a note, show edit button
                      noteState == NoteEnum.edit?Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              //Check that fields are valid
                              if(_formKey.currentState!.validate()) {
                                //Check if fields are changed before doing a DB write - this give a mess of ifs!
                                if(widget.currentNote!.title != titleFieldController.text) {
                                  widget.currentNote!.title =
                                      titleFieldController.text;
                                }
                                if(widget.currentNote!.notes != notesFieldController.text) {
                                    widget.currentNote!.notes =
                                        notesFieldController.text;
                                  }
                                  if(widget.currentNote!.temperature != widget.temperature) {
                                    widget.currentNote!.temperature =
                                        widget.temperature;
                                  }
                                  if(widget.currentNote!.time != widget.time) {
                                    widget.currentNote!.time = widget.time;
                                  }
                                  //Save any changes
                                  widget.currentNote!.save();
                                title = titleFieldController.text;
                                setState(() {
                                  widget.inEditState = false;
                                });
                                Get.snackbar(
                                    "$title has been edited",
                                    "Your notebook has been updated",
                                    snackPosition: SnackPosition.BOTTOM,
                                    icon: TextHelper.getCategoryIcon(_selectedCategory));

                                //Check if user should be prompted to review app
                                ReviewHelper.shouldPromptReview();


                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.save),
                                ),
                                Text("Update Note"),
                              ],
                            )
                        ),
                      ): const SizedBox(height: 0,)
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

  //Increase Time by 1 minute up to maximum
  double increaseTime(double currentTime){
    double maxTime = maximumTime;
    double returnTime = currentTime + 1;
    return returnTime < maxTime? returnTime : maxTime;
  }

  //Decrease Time by 1 minute up to maximum
  double decreaseTime(double currentTime){
    double minTime = minimumTime;
    double returnTime = currentTime - 1;
    return returnTime > minTime? returnTime : minTime;
  }

  Widget showTagline(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          'This note saved in Air Fryr',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic,),
        ),
      ),
    );
  }

}

