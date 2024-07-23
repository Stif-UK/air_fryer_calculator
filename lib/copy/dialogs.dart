import 'package:air_fryer_calculator/copy/help_copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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

}