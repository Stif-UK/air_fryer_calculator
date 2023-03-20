import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/copy/about_app_copy.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
      ),
      body: AboutAppCopy.getAboutAppCopy(),
    );
  }
}