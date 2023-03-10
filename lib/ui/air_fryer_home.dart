import 'package:flutter/material.dart';

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
      ),
    );
  }
}
