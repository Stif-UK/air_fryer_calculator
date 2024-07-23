import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppData extends StatefulWidget {
  const AppData({super.key});

  @override
  State<AppData> createState() => _AppDataState();
}

class _AppDataState extends State<AppData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appData),
      ),
      body: Column(

      ),
    );
  }
}
