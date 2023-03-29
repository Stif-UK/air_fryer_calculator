import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/copy/attributions_copy.dart';


class Attributions extends StatelessWidget {
  const Attributions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attributions"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("This app makes use of the following libraries to make it go!",
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
            ExpansionTile(title: const Text("Flutter Launcher Icons"),
            children: [
              AttributionsCopy.getAttributionFlutterIcons()
            ],),
          ],
        ),
      ),
    );
  }
}