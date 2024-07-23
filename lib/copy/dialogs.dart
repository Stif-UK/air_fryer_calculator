import 'dart:io';

import 'package:air_fryer_calculator/copy/help_copy.dart';
import 'package:air_fryer_calculator/model/backup_restore_methods.dart';
import 'package:air_fryer_calculator/model/notesmodel.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Dialogs{
  static getHelpDialog(BuildContext context){
    return Get.defaultDialog(
      title: "Deleted Notes",
      middleText: HelpCopy.getDeletedNotesHelp()
    );
  }

  static getTemperatureHelpDialog(){
    return Get.defaultDialog(
      title: "Temperature Reference",
      middleText: HelpCopy.getTemperatureHelpDialog()
    );
  }

  static getBackupSuccessDialog(){
    return Get.context != null ? Get.defaultDialog(
        title: AppLocalizations.of(Get.context!)!.backupComplete,
        barrierDismissible: true,
        middleText: AppLocalizations.of(Get.context!)!.noteBookSaved
    ) :
        Get.defaultDialog(
          title: "Backup Success",
          barrierDismissible: true,
          middleText: "Notebook Saved."
        );
  }

  static getBackupFailedDialog(String error){
    Get.defaultDialog(
        title: "Error",
        barrierDismissible: true,
        middleText: "Backup Failed\n\n"
            "$error\n\n"
            "It could be that the selected location is not accessible to the application. Try with a different location.\n\n"
            "If this doesn't work, please provide feedback to the developer via the app store."
    );
  }

  static getRestoreFailedDialog(String error){
    Get.defaultDialog(
        title: "Restore Failed",
        barrierDismissible: true,
        middleText: "Failed to restore from backup, an error occurred:\n\n"
            "$error\n\n"
            "Please try again - if the issue persists please contact the app developer"
    );
  }

  static getRestoreSuccessDialog(){
    Get.defaultDialog(
        title: "Restore Successful",
        barrierDismissible: true,
        middleText: "Database successfully restored!\n\n"
            "If notes don't show immediately try navigating between the main tabs.",
        confirmTextColor: Colors.white,
        buttonColor: Colors.lightBlueAccent,
        onConfirm: () async {
          var box = DataBaseHelper.getNotes();
          await box.close().then((_) => Hive.openBox<Notes>("NoteBook"));
          Get.back();
        }
    );
  }

  static getIncorrectFilenameDialog(String filename){
    Get.defaultDialog(
        title: "Incorrect file",
        barrierDismissible: true,
        middleText: "The file $filename does not match the expected file of notebook.hive\n\n"
            "Please select a notebook.hive file"
    );
  }

  static getConfirmRestoreDialog(File notebook){
    Get.defaultDialog(
        title: "Restore from Backup",
        barrierDismissible: false,
        middleText: "Restoring this backup will over-write your current notebook.\n\n"
            "Do you want to continue?",
        confirmTextColor: Colors.white,
        buttonColor: Colors.lightBlueAccent,
        onCancel: (){},
        onConfirm: (){
          BackupRestoreMethods.restoreNoteBook(notebook);
          Get.back();
        }
    );
  }

}