import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AirFryerTemperature extends StatelessWidget {
  const AirFryerTemperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Temperature Guide",
            style: Theme.of(context).textTheme.headlineMedium,),
          ),
        const Divider(thickness: 2,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.cow, size: 50,))),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text("Beef", style: Theme.of(context).textTheme.headlineSmall,),
                  Text("rare: 120F"),
                  Text("medium: 111F"),
                  Text("well done: 150F")
                ],

              ),
            )
          ],
        ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text("Pork", style: Theme.of(context).textTheme.headlineSmall,),
                    Text(""),
                    Text("temp: 145F"),
                    Text(""),
                  ],
                ),
              ),
              Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.bacon, size: 50,))),
            ],
          ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.drumstickBite, size: 50,))),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text("Poultry", style: Theme.of(context).textTheme.headlineSmall,),
                    Text("breast: 165F"),
                    Text("thigh: 170F"),
                    Text(""),
                  ],

                ),
              ),
            ],
          ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text("Fish", style: Theme.of(context).textTheme.headlineSmall,),
                    Text(""),
                    Text("temp: 137"),
                    Text(""),
                  ],
                ),
              ),
              Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.fish, size: 50,))),
            ],
          ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.cakeCandles, size: 50,))),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text("Baking", style: Theme.of(context).textTheme.headlineSmall,),
                    Text("cake: 210F"),
                    Text("bread: 210F"),
                    Text("brownies: 190F"),
                  ],

                ),
              ),
            ],
          ),
          const Divider(thickness: 2,),




        ],
      ),
    );
  }
}

