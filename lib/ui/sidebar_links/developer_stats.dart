import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';


class DeveloperStats extends StatefulWidget {
  const DeveloperStats({Key? key}) : super(key: key);

  @override
  State<DeveloperStats> createState() => _DeveloperStatsState();
}

class _DeveloperStatsState extends State<DeveloperStats> {
  @override
  Widget build(BuildContext context) {
    //String purchaseDate = await getPurchaseDate();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Stats"),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Divider(thickness: 2,),
            ListTile(
              title: const Text("Open Count"),
              subtitle: Text("App Opened: ${FryerPreferences.getOpenCount()} times"),
            ),
            Divider(thickness: 2,),
            ListTile(
              title: const Text("First Used"),
                subtitle: Text("${TextHelper.formatDate(FryerPreferences.getFirstUseDate()!)}"),
            ),
            Divider(thickness: 2,),
            ListTile(
              title: const Text("App Purchased"),
              subtitle: Text("${FryerPreferences.getAppPurchasedStatus() ?? false}"),
            ),
            Divider(thickness: 2,),
            FutureBuilder(
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return ListTile(
                        title: Text('${snapshot.error} occurred'),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data as String;
                      return ListTile(
                        title: const Text("Purchase Date"),
                        subtitle: Text(
                          '$data',

                        ),
                      );
                    }
                  }
              return ListTile(
                title: const Text("Purchase Date"),
                trailing: CircularProgressIndicator(),
              );

            },
              future: getPurchaseDate(),

            ),
            Divider(thickness: 2,),
            FutureBuilder(
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('${snapshot.error} occurred'),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    final data = snapshot.data as String;
                    return ListTile(
                      title: const Text("Last Donation Date"),
                      subtitle: Text(
                        '$data',

                      ),
                    );
                  }
                }
                return ListTile(
                  title: const Text("Last Donation Date"),
                  trailing: CircularProgressIndicator(),
                );

              },
              future: getLastDonationDate(),

            ),
            Divider(thickness: 2,),
            FutureBuilder(
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('${snapshot.error} occurred'),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    final data = snapshot.data as String;
                    return ListTile(
                      title: const Text("Last Entitlement Check"),
                      subtitle: Text(
                        '$data',

                      ),
                    );
                  }
                }
                return ListTile(
                  title: const Text("Last Entitlement Check"),
                  trailing: CircularProgressIndicator(),
                );

              },
              future: getLastEntilementCheck(),

            ),

          ],
        ),
      ),
    );
  }

  Future<String> getPurchaseDate() async {
    return  FryerPreferences.getAppPurchasedStatus() ?? false ? TextHelper.formatDate(DateTime.parse(await PurchaseApi.getAppPurchaseDate(true))): "N/A";
  }

  Future<String> getLastDonationDate() async{
    return FryerPreferences.getAppPurchasedStatus() ?? false ? TextHelper.formatDate(DateTime.parse(await PurchaseApi.getAppPurchaseDate(false))): "N/A";
  }

  Future<String> getLastEntilementCheck() async{
    return FryerPreferences.getLastEntitlementCheckDate() != null ? TextHelper.formatDate(await FryerPreferences.getLastEntitlementCheckDate()!): "N/A";
  }
}




// "Last Entitlement Check: ${FryerPreferences.getLastEntitlementCheckDate() != null ? TextHelper.formatDate(await FryerPreferences.getLastEntitlementCheckDate()!): "N/A"}\n\n"
// );
