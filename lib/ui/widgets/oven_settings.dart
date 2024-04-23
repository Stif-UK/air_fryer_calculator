import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/util/string_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvenSettings extends StatefulWidget {
  OvenSettings({super.key,
  required this.isTemp});

  bool isTemp;
  final fryerController = Get.put(FryerController());

  @override
  State<OvenSettings> createState() => _OvenSettingsState();
}

class _OvenSettingsState extends State<OvenSettings> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Controller
  final settingsFieldController = TextEditingController();

  @override
  void dispose(){
    //clean up the controller when the widget is disposed
    settingsFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isTemp? Text("Input oven temperature"): Text("Input oven time in minutes"),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key:_formKey,
              child: TextFormField(
                controller: settingsFieldController,
                keyboardType: TextInputType.number,
                validator: (String? val) {
                  if(widget.isTemp) {
                  if (!val!.isValidTemp) {
                    return 'Must be a number between 0 & 450';
                  }
                } else {
                    if (!val!.isValidTime) {
                      return 'Must be a number between 0 & 180';
                    }
                  }
              },
              )),
        ),
        ElevatedButton(
            child: Text("Update"),
        onPressed: (){
              if(_formKey.currentState!.validate()){
                widget.isTemp? widget.fryerController.updateTemperature(double.parse(settingsFieldController.text)):
                    widget.fryerController.updateTime(double.parse(settingsFieldController.text));
                Get.back();
              }

        },)

      ]
    );
  }
}
