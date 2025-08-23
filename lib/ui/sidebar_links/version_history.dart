import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/copy/version_history_copy.dart';
import 'package:air_fryer_calculator/l10n/app_localizations.dart';


class VersionHistory extends StatelessWidget {
  const VersionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.versionHistory),
      ),
      body: VersionHistoryCopy.getFullVersionHistory(),


    );
  }
}
