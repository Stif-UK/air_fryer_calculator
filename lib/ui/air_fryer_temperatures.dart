import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AirFryerTemperature extends StatelessWidget {
  const AirFryerTemperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Text("Rare: 120F"),
                Text("Medium: 111F"),
                Text("Well Done: 150F")
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
                  Text("Poultry", style: Theme.of(context).textTheme.headlineSmall,),
                  Text("breast: 165F"),
                  Text("thigh: 170F"),
                ],
              ),
            ),
            Expanded(flex: 5, child: Center(child: Icon(FontAwesomeIcons.drumstickBite, size: 50,))),
          ],
        ),
        const Divider(thickness: 2,),


        //   Table(
      //     border: TableBorder.all(color: Colors.white24),
      //     children: [
      //       buildRow(context, Icon(FontAwesomeIcons.temperatureQuarter) ,["","Rare","Medium", "Well Done"]),
      //       buildRow(context, Icon(FontAwesomeIcons.drumstickBite), ["Poultry", "", "", "79"]),
      //       buildRow(context, Icon(FontAwesomeIcons.cow), ["Red Meat","60", "71", "77"]),
      //       buildRow(context,Icon(FontAwesomeIcons.fish), ["Fish", "", "", "58"])
      //     ],
      //   )
      //
      ],
    );
  }
}

// TableRow buildRow(BuildContext context, Icon icon, List<String> cells) {
//   List<Widget> childList = [];
//   childList.add(Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Center(child: icon),
//   ));
//   childList.addAll(cells.map((cell) =>
//       Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: Center(child: Text(cell,
//           style: Theme
//               .of(context)
//               .textTheme
//               .bodyLarge,)),
//       )).toList());
//   return TableRow(
//       children: childList
//   );
// }
