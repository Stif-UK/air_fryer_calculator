import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/util/startup_helper.dart';
import 'package:air_fryer_calculator/util/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class DeveloperStats extends StatefulWidget {
  const DeveloperStats({Key? key}) : super(key: key);

  @override
  State<DeveloperStats> createState() => _DeveloperStatsState();
}

class _DeveloperStatsState extends State<DeveloperStats> {
  @override
  Widget build(BuildContext context) {
    final fryerController = Get.put(FryerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Stats"),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Divider(thickness: 2,),
            ListTile(
              title: const Text("Open Count"),
              subtitle: Text("App Opened: ${FryerPreferences.getOpenCount()} times"),
            ),
            const Divider(thickness: 2,),
            ListTile(
              title: const Text("First Used"),
                subtitle: Text("${TextHelper.formatDate(FryerPreferences.getFirstUseDate()!)}"),
            ),
            const Divider(thickness: 2,),
            ListTile(
              title: const Text("App Purchased"),
              subtitle: Text("${FryerPreferences.getAppPurchasedStatus() ?? false}"),
            ),
            const Divider(thickness: 2,),
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
            const Divider(thickness: 2,),
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
            const Divider(thickness: 2,),
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
            const Divider(thickness: 2,),
            ListTile(
              title: const Text("Revert Purchase Status"),
              subtitle: const Text("Remove pro option and show ads by clicking here. If done in error purchases can be restored on the 'remove ads' page"),
              onTap: (){
                fryerController.revertPurchaseStatus();
                Get.snackbar(
                    "Reverted",
                    "User is no longer Pro on this app",
                    icon: const Icon(Icons.no_accounts),
                    snackPosition: SnackPosition.BOTTOM
                );
              },
            ),
            const Divider(thickness: 2,),
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
                      title: const Text("App User ID"),
                      subtitle: Text(
                        '$data',

                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: (){
                          //Copy the appUserID to the clipboard
                          Clipboard.setData(ClipboardData(text:'$data'));
                          Get.snackbar(
                            "Copied",
                             "appUserID saved to clipboard",
                            icon: Icon(Icons.copy),
                            snackPosition: SnackPosition.BOTTOM
                          );

                        },
                      ),
                    );
                  }
                }
                return ListTile(
                  title: const Text("App User ID"),
                  trailing: CircularProgressIndicator(),
                );

              },
              future: PurchaseApi.getAppUserID(),

            ),
            const Divider(thickness: 2,),
            ListTile(
              title: Text("Show what's new dialog"),
              subtitle: Text("Trigger the what's new pop-up for testing purposes"),
              onTap: (){
                StartupChecksUtil.showWhatsNewDialog();
              },
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
