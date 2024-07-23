import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Backup",
                      style: TextStyle(
                        fontSize: 30,
                      ),),
                  ),
                  onPressed: (){
                    //Get.to(() => ShareBackup());
                    //Platform.isIOS? Get.to(()=> const ShareBackup()) :Get.to(() => const Backup());
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary),
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
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Restore",
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                    ),
                    onPressed: (){
                      //Get.to(() => const Restore());
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Theme.of(context).buttonTheme.colorScheme!.inversePrimary),
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
