import 'dart:io';
import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';
import 'package:air_fryer_calculator/ui/air_fryer_temperatures.dart';
import 'package:air_fryer_calculator/ui/search/search.dart';
import 'package:air_fryer_calculator/util/startup_helper.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/ui/air_fryer_calculator.dart';
import 'package:air_fryer_calculator/ui/air_fryer_notes.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/ui/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AirFryerHome extends StatefulWidget {
  const AirFryerHome({Key? key}) : super(key: key);

  @override
  State<AirFryerHome> createState() => _AirFryerHomeState();
}

class _AirFryerHomeState extends State<AirFryerHome> {
  final fryerController = Get.put(FryerController());
  int _selectedIndex = 0;
  final List<Widget> _children =[
    AirFryerCalculator(),
    AirFryerNotes(),
    AirFryerTemperature()
  ];

  @override
  Widget build(BuildContext context) {
    //If platform is iOS, request tracking permission for ads
    if(Platform.isIOS) {
      AppTrackingTransparency.requestTrackingAuthorization();
    }

    //If app is pro, check entitlement is still valid - check once per week
    if(FryerPreferences.getAppPurchasedStatus() == true){
      final lastChecked = FryerPreferences.getLastEntitlementCheckDate();
      if(lastChecked == null){
        PurchaseApi.checkEntitlements();
      } else {
        final date2 = DateTime.now();
        final difference = date2.difference(lastChecked).inDays;
        if(difference > 6){
          PurchaseApi.checkEntitlements();
        }
      }

    }

    StartupChecksUtil.runStartupChecks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Fryr', style: TextStyle(fontStyle: FontStyle.italic),),
        //backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: SearchWidget());
              },
            ),
          )
        ],
      ),
      floatingActionButton: _selectedIndex == 1? FloatingActionButton(
        backgroundColor: Colors.red,
        //foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => AddNotes(time: 30.0, temperature: 200.0));
        },
        child: const Icon(Icons.add),
      ) : null,
      drawer: NavBar(),
      onDrawerChanged: (isOpen){
        fryerController.updateIsDrawerOpen(isOpen);
      },
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: AppLocalizations.of(context)!.calculator
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: AppLocalizations.of(context)!.notes
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: AppLocalizations.of(context)!.tempGuide
          )
        ],
        currentIndex: _selectedIndex,
          onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


