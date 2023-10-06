import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AirFryerTemperature extends StatelessWidget {
  AirFryerTemperature({Key? key}) : super(key: key);
  final fryerController = Get.put(FryerController());

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
              child: Obx(() => Column(
                children: [
                  Text("Beef", style: Theme.of(context).textTheme.headlineSmall,),
                  Text("rare: ${fryerController.tempIsCelcius.value == true? "60": "140"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                  Text("medium: ${fryerController.tempIsCelcius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                  Text("well done: ${fryerController.tempIsCelcius.value == true? "77": "170"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}")
                ],

              )),
            )
          ],
        ),
          const Divider(thickness: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Obx(() => Column(
                    children: [
                      Text("Pork", style: Theme.of(context).textTheme.headlineSmall,),
                      Text(""),
                      Text("temp: ${fryerController.tempIsCelcius.value == true? "71": "160"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text(""),
                    ],
                  ),
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
                child: Obx(()=> Column(
                    children: [
                      Text("Poultry", style: Theme.of(context).textTheme.headlineSmall,),
                      Text("pieces: ${fryerController.tempIsCelcius.value == true? "74": "165"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text("whole: ${fryerController.tempIsCelcius.value == true? "85": "185"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text(""),
                    ],

                  ),
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
                child: Obx(() => Column(
                    children: [
                      Text("Fish", style: Theme.of(context).textTheme.headlineSmall,),
                      Text(""),
                      Text("temp: ${fryerController.tempIsCelcius.value == true? "58": "137"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text(""),
                    ],
                  ),
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
                child: Obx(() => Column(
                    children: [
                      Text("Baking", style: Theme.of(context).textTheme.headlineSmall,),
                      Text("cake: ${fryerController.tempIsCelcius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text("bread: ${fryerController.tempIsCelcius.value == true? "98": "210"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                      Text("brownies: ${fryerController.tempIsCelcius.value == true? "88": "190"}${TextHelper.getTempSuffix(fryerController.tempIsCelcius.value)}"),
                    ],

                  ),
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

