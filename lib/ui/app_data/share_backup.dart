import 'package:air_fryer_calculator/model/adUnits.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';
import 'package:air_fryer_calculator/provider/adstate.dart';
import 'package:air_fryer_calculator/util/ad_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/copy/dialogs.dart';
import 'package:air_fryer_calculator/model/backup_restore_methods.dart';

class ShareBackup extends StatefulWidget {
  ShareBackup({Key? key}) : super(key: key);
  final fryerController = Get.put(FryerController());

  @override
  State<ShareBackup> createState() => _ShareBackupState();
}

class _ShareBackupState extends State<ShareBackup> {

  BannerAd? banner;
  bool purchaseStatus = FryerPreferences.getAppPurchasedStatus() ?? false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!purchaseStatus)
    {
      final adState = Provider.of<AdState>(context);
      adState.initialization.then((status) {
        setState(() {
          banner = BannerAd(
            //TODO: Update AdUnit
              adUnitId: AdUnits.backupPageBannerAdUnitID,
              //If the device screen is large enough display a larger ad on this screen
              size: AdSize.banner,
              request: const AdRequest(),
              listener: adState.adListener)
            ..load();
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Backup"),
        actions: [
          IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: (){
                //Dialogs.getBackupHelpDialog();
              } )
        ],
      ),
      body: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Press the button below to create a copy of the app database (this can take a few seconds!). \n\nOnce created a 'share' pop-up should appear, allowing you to choose where to send the backup file.  ",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Backup Database",
                    style: Theme.of(context).textTheme.headlineSmall,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(FontAwesomeIcons.download),
                    )
                  ],
                ),
                onPressed: () async {
                  BackupRestoreMethods.shareBackup();

                },
              ),
            ),
            Expanded(child:
            SizedBox()),
            //Insert Ad Widget into tree
            widget.fryerController.isAppPro.value? const SizedBox(height: 0,) : AdWidgetHelper.buildSmallAdSpace(banner, context),
            const SizedBox(height: 20,)
                  ],
                ),
              ),
            );
  }
}
