import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/copy/version_history_copy.dart';

class VersionHistory extends StatelessWidget {
  const VersionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Version History"),
      ),
      body: VersionHistoryCopy.getFullVersionHistory(),


    );
  }
}
