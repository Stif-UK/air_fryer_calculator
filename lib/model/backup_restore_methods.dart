import 'dart:io';
import 'package:path/path.dart';
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

  static restoreNoteBook(File notebook) async {
    final box = DataBaseHelper.getNotes();
    final _boxPath = box.path;
    bool _error = false;
    try{
      await notebook.copy(_boxPath!).onError((error, stackTrace) => Dialogs.getRestoreFailedDialog(error.toString()));
    } catch(e) {
      _error = true;
      Dialogs.getRestoreFailedDialog(e.toString());
    } finally{
      _error? print("Finally called") : Dialogs.getRestoreSuccessDialog();
    }
  }

  /*
  This method is called during the RESTORE process to select the backup file to restore from.
  Updated to clear any file cache before selecting the file to ensure an old version of the watchbox
  isn't utilised for the restore.
   */
  static Future<File?> pickBackupFile() async {
    FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;

    if (result != null) {
      String fileName = basename(result.files.single.path!);
      fileName == "notebook.hive"? file = File(result.files.single.path!): Dialogs.getIncorrectFilenameDialog(fileName);
    }
    return file;
  }

}