import 'package:flutter/material.dart';

class AirFryerCalculator extends StatefulWidget {
  const AirFryerCalculator({Key? key}) : super(key: key);

  @override
  State<AirFryerCalculator> createState() => _AirFryerCalculatorState();
}

class _AirFryerCalculatorState extends State<AirFryerCalculator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Air Fryer Calculator"),
    );
  }
}
