import 'package:air_fryer_calculator/ui/app_data/share_backup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';


class AppData extends StatefulWidget {
  const AppData({super.key});

  @override
  State<AppData> createState() => _AppDataState();
}

class _AppDataState extends State<AppData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appData),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            SizedBox(
              width: (MediaQuery.of(context).size.width)*0.8,
              height: (MediaQuery.of(context).size.height)*0.15,
              child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Backup",
                      style: Theme.of(context).textTheme.headlineLarge
                    ),
                  ),
                  onPressed: (){
                    Get.to(() => ShareBackup());
                  },
                  style: ButtonStyle(
                      backgroundColor: Get.isDarkMode? WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary) : WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.primary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Colors.black)
                          )

                      )
                  )
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: (MediaQuery.of(context).size.width)*0.8,
                height: (MediaQuery.of(context).size.height)*0.15,
                child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Restore",
                        style: Theme.of(context).textTheme.headlineLarge
                      ),
                    ),
                    onPressed: (){
                      //Get.to(() => const Restore());
                    },
                    style: ButtonStyle(
                        backgroundColor: Get.isDarkMode? WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary) : WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.primary),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: const BorderSide(color: Colors.black)
                            )

                        )
                    )
                ),
              ),
            ),
          ],
        ));
  }
}
