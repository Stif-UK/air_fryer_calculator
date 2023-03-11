import 'package:flutter/material.dart';

class AirFryerCalculator extends StatefulWidget {
  const AirFryerCalculator({Key? key}) : super(key: key);

  @override
  State<AirFryerCalculator> createState() => _AirFryerCalculatorState();
}

class _AirFryerCalculatorState extends State<AirFryerCalculator> {
  double temperature = 200;
  double time = 40;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Oven Temperature: ${temperature.toInt()}°C",
          style: Theme.of(context).textTheme.bodyMedium,),
          Slider(
            value: temperature,
            min: 150,
            max: 350,
            onChanged: (double value) {
              setState(()
                => temperature = value);
              },
          divisions: 20,
          label: "${temperature.toInt()}°C",),
          //Text("${temperature.toInt()}°C"),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,25),
            child: Text("Oven Time: ${time.toInt()} minutes",
            style: Theme.of(context).textTheme.bodyMedium,),
          ),
          Slider(
            value: time,
            min: 0,
            max: 180,
            onChanged: (double value) {
              setState(()
              => time = value);
            },
            divisions: 36,
            label: "${time.toInt()} mins",),
          //Text("${time.toInt()} minutes")
          const Divider(thickness: 2,),
          //Display the output
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Suggested Air Fryer Setting",style: Theme.of(context).textTheme.bodyLarge,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Temperature: ${temperature.toInt() - 20}°C",
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Time:\n ${(time * 0.8).toInt()} minutes",
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,),
          ),


        ]
      ),
    );
  }
}
