import 'dart:io';

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
    const AirFryerNotes(),
  ];

  @override
  Widget build(BuildContext context) {
    //If platform is iOS, request tracking permission for ads
    if(Platform.isIOS) {
      AppTrackingTransparency.requestTrackingAuthorization();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AirFry Calc'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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


