import 'dart:io';
import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/ui/add_notes.dart';
import 'package:air_fryer_calculator/ui/search/search.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/ui/air_fryer_calculator.dart';
import 'package:air_fryer_calculator/ui/air_fryer_notes.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/ui/navbar.dart';

class AirFryerHome extends StatefulWidget {
  const AirFryerHome({Key? key}) : super(key: key);

  @override
  State<AirFryerHome> createState() => _AirFryerHomeState();
}

class _AirFryerHomeState extends State<AirFryerHome> {
  int _selectedIndex = 0;
  final List<Widget> _children =[
    AirFryerCalculator(),
    AirFryerNotes(),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Fryr', style: TextStyle(fontStyle: FontStyle.italic),),
        //backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                  context: context,
                  delegate: SearchWidget());
            },
          )
        ],
      ),
      floatingActionButton: _selectedIndex == 0? null : FloatingActionButton(
        backgroundColor: Colors.red,
        //foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => AddNotes(time: 30.0, temperature: 200.0));
        },
        child: const Icon(Icons.add),
      ),
      drawer: NavBar(),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calculator'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Notes'
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


