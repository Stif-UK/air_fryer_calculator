import 'dart:io';

import 'package:air_fryer_calculator/copy/dialogs.dart';
import 'package:air_fryer_calculator/util/database_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

class BackupRestoreMethods{

  static Future<String?> pickBackupLocation() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return null;
    } else {
      return selectedDirectory;
    }
  }

  static Future<ShareResult> shareBackup() async {
    final box = DataBaseHelper.getNotes();
    final boxPath = box.path;
    var result = await Share.shareXFiles([XFile(boxPath!)]);

    if (result.status == ShareResultStatus.success) {
      Dialogs.getBackupSuccessDialog();
    }

    return result;
  }

  static Future<void> backupNoteBook<Notes>(String backupPath) async {

    final box = DataBaseHelper.getNotes();
    final boxPath = box.path;

    try {
      bool _errored = false;
      backupPath = backupPath+"/watchbox.hive";
      await File(boxPath!).copy(backupPath).onError((error, stackTrace) {
        _errored = true;
        Dialogs.getBackupFailedDialog(error.toString());
        throw Exception();
      }
      ).whenComplete(() => _errored? print("error"):File(backupPath).exists().then((_) => Dialogs.getBackupSuccessDialog()));

    } catch(e) {
      print("Caught exception: $e");
    }

  }

}