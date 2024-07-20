import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/controller/LanguageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  Settings({super.key});
  final fryerController = Get.put(FryerController());
  final languageController = Get.put(LanguageController());

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Obx(()=> SwitchListTile(
              title: widget.fryerController.tempIsCelsius.value? const Text("Temperature: Celsius"): const Text("Temperature: Fahrenheit"),
              value: widget.fryerController.tempIsCelsius.value,
              onChanged: (bool newValue) async{
                widget.fryerController.tempIsCelsius(newValue);
              },

            ),
          ),
          const Divider(thickness: 2,),

        ],
      ),
    );
  }
}
