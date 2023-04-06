import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:flutter/material.dart';

class RemoveAdsSheet{
  static Widget getRemoveAdsSheet(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Support Air Fryr",
          style: Theme.of(context).textTheme.headlineSmall,),
        ),
        Padding(padding: EdgeInsets.all(20),
        child: RemoveAdsCopy.getRemoveAdsSheetCopy(context),),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: OutlinedButton(
              onPressed: (){},
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Buy me a coffee: ",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                  ),
                  Text("£2",
                  textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyLarge,)
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: OutlinedButton(
              onPressed: (){},
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Buy me a pizza: ",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                  ),
                  Text("£5",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyLarge,)
                ],
              )),
        ),


      ],
    );
  }
}