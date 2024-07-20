import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/copy/attributions_copy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Attributions extends StatelessWidget {
  const Attributions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.attributions),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("This app makes use of the following libraries and tools to make it go!",
              style: Theme.of(context).textTheme.bodyLarge,),
            ),
            ExpansionTile(title: const Text("FontAwesome"),
              children: [
                AttributionsCopy.getAttributionFontAwesome()
              ],),
            ExpansionTile(title: const Text("Hive Database"),
              children: [
                AttributionsCopy.getAttributionHive(),
              ],),
            ExpansionTile(title: const Text("GetX"),
              children: [
                AttributionsCopy.getAttributionGetX(),
              ],),
            ExpansionTile(title: const Text("App Icons"),
            children: [
              AttributionsCopy.getAttributionFlutterIcons()
            ],),
            const Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("${AppLocalizations.of(context)!.translations}:",
                style: Theme.of(context).textTheme.bodyLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("I would also like to express thanks to Folkert Voos for supporting the Dutch translation of the app"),
            )
          ],
        ),
      ),
    );
  }
}