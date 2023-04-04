import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';

class NoteListtile extends StatelessWidget{
  const NoteListtile({
    Key? key,
    required this.currentNote,
  }) : super(key: key);

  final Notes currentNote;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TextHelper.getCategoryIcon(TextHelper.getEnumFromString(currentNote.category)),
      title: Text(currentNote.title),
      subtitle: Text("${currentNote.temperature.toInt()}${TextHelper.getTempSuffix(currentNote.isCelcius)} for ${currentNote.time.toInt()} minutes"),
      onTap: (){
        Get.to(() => AddNotes(time: currentNote.time, temperature: currentNote.temperature, currentNote: currentNote,));
      },
    );
  }



}