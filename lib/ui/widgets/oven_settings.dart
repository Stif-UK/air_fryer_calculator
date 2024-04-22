import 'package:air_fryer_calculator/controller/FryerController.dart';
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
  final tempFieldController = TextEditingController();
  final timeFieldController = TextEditingController();

  @override
  void dispose(){
    //clean up the controller when the widget is disposed
    tempFieldController.dispose();
    timeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isTemp? Text("Oven Temperature"): Text("Oven Time"),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key:_formKey,
              child: TextFormField(
                controller: widget.isTemp? tempFieldController: timeFieldController,
                keyboardType: TextInputType.number,
                //initialValue: "Temp: ${widget.fryerController.temperature.value} C",
              )),
        ),
        ElevatedButton(
            child: Text("Update"),
        onPressed: (){},)

      ]
    );
  }
}
