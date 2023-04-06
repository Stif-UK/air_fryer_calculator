import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:flutter/material.dart';

class RemoveAds extends StatefulWidget {
  const RemoveAds({Key? key}) : super(key: key);

  @override
  State<RemoveAds> createState() => _RemoveAdsState();
}

class _RemoveAdsState extends State<RemoveAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove Ads"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
              child: Center(child: RemoveAdsCopy.getRemoveAdsCopy()),
            ),



          ],
        ),
      )
    );
  }
}
