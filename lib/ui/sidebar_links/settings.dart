import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/controller/LanguageController.dart';
import 'package:air_fryer_calculator/util/flag_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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


      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(AppLocalizations.of(context)!.english),
        ),value: "en"),
        DropdownMenuItem(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(AppLocalizations.of(context)!.dutch),
        ),value: "nl"),

      ];


    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          Obx(()=> SwitchListTile(
              title: widget.fryerController.tempIsCelsius.value? Text(AppLocalizations.of(context)!.tempCelsius): Text(AppLocalizations.of(context)!.tempFahrenheit),
              value: widget.fryerController.tempIsCelsius.value,
              onChanged: (bool newValue) async{
                widget.fryerController.tempIsCelsius(newValue);
              },

            ),
          ),
          const Divider(thickness: 2,),
          Obx(()=> ListTile(
              title: Text("${AppLocalizations.of(context)!.language}:"),
              trailing: DropdownButton(
                icon: FlagHelper.getFlag(widget.languageController.locale.value),
                value: widget.languageController.locale.value.languageCode,
                items: menuItems,
                onChanged: (newValue){
                  widget.languageController.updateLocalePref(Locale(newValue!));
                }


              ),
            ),
          ),
          const Divider(thickness: 2,)

        ],
      ),
    );
  }
}
