import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:get/get.dart';

class DataBaseHelper {
  static getNotes(){
    return Hive.box<Notes>("NoteBook");
  }

  static Future addNote(String title, CategoryEnum category, double temperature, double time, String? notes, bool isCelcius){
    final note = Notes()
        ..title = title
        ..category = category.toString()
        ..temperature = temperature
        ..time = time
        ..notes = notes
        ..isCelcius = isCelcius;

    final Box<Notes> box = getNotes();
    return box.add(note);
  }

  static noteAddedSnackbar(String title){
    Get.snackbar("$title added to notebook", "Your notebook has been updated");
  }
}