import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';
import 'package:air_fryer_calculator/l10n/app_localizations.dart';


class NoteListtile extends StatelessWidget{
  const NoteListtile({
    Key? key,
    required this.currentNote,
  }) : super(key: key);

  final Notes currentNote;

  @override
  Widget build(BuildContext context) {
    bool favourite = currentNote.isFavourite ?? false;
    return ListTile(
      leading: TextHelper.getCategoryIcon(TextHelper.getEnumFromString(currentNote.category)),
      trailing: IconButton(
        icon: favourite? Icon(Icons.star): Icon(Icons.star_border),
        onPressed: (){
          DataBaseHelper.setFavouriteState(currentNote, !favourite);
        },
      ),
      title: Text(currentNote.title),
      subtitle: Text("${currentNote.temperature.toInt()}${TextHelper.getTempSuffix(currentNote.isCelcius)} for ${currentNote.time.toInt()} ${AppLocalizations.of(context)!.minutes}"),
      onTap: (){
        Get.to(() => AddNotes(time: currentNote.time, temperature: currentNote.temperature, currentNote: currentNote,));
      },
    );
  }



}