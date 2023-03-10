import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/ui/navbar.dart';

class AirFryerHome extends StatefulWidget {
  const AirFryerHome({Key? key}) : super(key: key);

  @override
  State<AirFryerHome> createState() => _AirFryerHomeState();
}

class _AirFryerHomeState extends State<AirFryerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AF Calc'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: Column(),
    );
  }
}
