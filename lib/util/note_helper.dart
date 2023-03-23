import 'package:air_fryer_calculator/model/enums/note_enums.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:flutter/material.dart';

class NoteHelper{

  static NoteEnum getNoteViewState(Notes? note, bool canEdit){
    if(note == null){
      //State 1: Add note
      print("Returned Add");
      return NoteEnum.add;
    } else if(canEdit){
      //State 2: Edit Note
      print("Returned Edit");
      return NoteEnum.edit;
    }
    //State 3(default): View Note
    print("Returned View");
    return NoteEnum.view;
  }

  static Widget getTitle(NoteEnum noteState, String title){
    String returnText = title;
    switch(noteState){
      case NoteEnum.edit:
        returnText = "Edit: $title";
        break;
      case NoteEnum.add:
        returnText = "Save Note";
        break;
      case NoteEnum.view:
        returnText = title;
        break;
    }

    return Text(returnText);
  }
}