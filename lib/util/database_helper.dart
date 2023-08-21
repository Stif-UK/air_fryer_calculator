import 'package:air_fryer_calculator/model/enums/category_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:get/get.dart';

class DataBaseHelper {
  static getNotes(){
    return Hive.box<Notes>("NoteBook");
  }

  static getNotesByCategory(CategoryEnum category){

    Box<Notes> notebook = DataBaseHelper.getNotes();
    List <Notes>returnList = notebook.values.where((note) => note.isArchived != true).toList();

    switch (category){

      case CategoryEnum.sides:
        returnList = returnList.where((note) => note.category == CategoryEnum.sides.toString()).toList();
        break;
      case CategoryEnum.meat:
        returnList = returnList.where((note) => note.category == CategoryEnum.meat.toString()).toList();
        break;
      case CategoryEnum.seafood:
        returnList = returnList.where((note) => note.category == CategoryEnum.seafood.toString()).toList();
        break;
      case CategoryEnum.poultry:
        returnList = returnList.where((note) => note.category == CategoryEnum.poultry.toString()).toList();
        break;
      case CategoryEnum.vegetarian:
        returnList = returnList.where((note) => note.category == CategoryEnum.vegetarian.toString()).toList();
        break;
      case CategoryEnum.vegan:
        returnList = returnList.where((note) => note.category == CategoryEnum.vegan.toString()).toList();
        break;
      case CategoryEnum.dessert:
        returnList = returnList.where((note) => note.category == CategoryEnum.dessert.toString()).toList();
        break;
      case CategoryEnum.other:
        returnList = returnList.where((note) => note.category == CategoryEnum.other.toString()).toList();
        break;
      case CategoryEnum.all:
            returnList = notebook.values.where((note) => note.isArchived != true).toList();
        break;
    }
    return returnList;
  }

  static List<Notes> getArchivedNotes(){
    final Box<Notes> notebook = getNotes();
    return notebook.values.where((note) => note.isArchived == true).toList();
  }

  static Future addNote(String title, CategoryEnum category, double temperature, double time, String? notes, bool isCelcius, bool isFavourite){
    final note = Notes()
        ..title = title
        ..category = category.toString()
        ..temperature = temperature
        ..time = time
        ..notes = notes
        ..isCelcius = isCelcius
        ..isArchived = false
        ..isFavourite = isFavourite;

    final Box<Notes> box = getNotes();
    return box.add(note);
  }

  static setFavouriteState(Notes currentNote, bool favourite){
    currentNote.isFavourite = favourite;
    currentNote.save();
  }



  static noteAddedSnackbar(String title){
    Get.snackbar("$title added to notebook", "Your notebook has been updated");
  }
}