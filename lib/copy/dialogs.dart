import 'package:air_fryer_calculator/copy/help_copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs{
  static getHelpDialog(BuildContext context){
    return Get.defaultDialog(
      title: "Deleted Notes",
      middleText: HelpCopy.getDeletedNotesHelp()
    );
  }
}