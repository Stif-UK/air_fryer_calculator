import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/about_app.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/attributions.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/deleted_notes.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/developer_stats.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/privacy_landing.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/remove_ads.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/settings.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/version_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);
  final fryerController = Get.find<FryerController>();

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  final InAppReview inAppReview = InAppReview.instance;
  String _buildVersion = "Not Determined";

  @override
  void initState() {
    super.initState();
    _getBuildVersion().then((val) {
      setState(() {
        _buildVersion = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int clickCounter =0;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(child: IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.fastfood, size: 40.0),
                  onPressed: () async {
                    print(clickCounter);
                    clickCounter++;
                    print(clickCounter);
                    if (clickCounter > 5) {
                      Get.to(() => DeveloperStats());
                    }
                  },

                )),

                ListTile(
                  title: Text(AppLocalizations.of(context)!.settings),
                  trailing: const Icon(Icons.settings),
                  onTap: (){
                    Get.to(() => Settings());
                  },
                ),
                const Divider(thickness: 2,),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.privacy),
                  trailing: const Icon(Icons.privacy_tip_outlined),
                  onTap: (){
                    Get.to(() => PrivacyLanding());
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.aboutApp),
                  trailing: const Icon(Icons.info_outline),
                  onTap: (){
                    Get.to(() => const AboutApp());
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.attributions),
                  trailing: const Icon(Icons.check_box_outlined),
                  onTap: (){
                    Get.to(() => const Attributions());
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.versionHistory),
                  trailing: const Icon(Icons.history),
                  onTap: (){
                    Get.to(() => const VersionHistory());
                  },
                ),
                const Divider(thickness: 2,),
                ListTile(
                  title: widget.fryerController.isAppPro.value? RemoveAdsCopy.getPageTitleSupporter(context):  RemoveAdsCopy.getPageTitle(context),
                  trailing: const Icon(Icons.money_off),
                  onTap: (){
                    Get.to(() => RemoveAds());
                  },
                ),
                const Divider(thickness: 2,),
                //const SizedBox(height: 100,),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.appReview),
                  trailing: const Icon(Icons.reviews_outlined),
                  onTap: (){
                    inAppReview.openStoreListing(
                      appStoreId: "6446950736"
                    );

                  },
                ),
                const Divider(thickness: 2,)

              ],
            ),
          ),
              const Divider(thickness: 2,),
              ListTile(
                title: Text(AppLocalizations.of(context)!.deletedNotes),
                trailing: const Icon(Icons.delete_outline),
                onTap: (){
                    Get.to(() => const DeletedNotes());
                  }),
          const SizedBox(height: 20,),
          Text("${AppLocalizations.of(context)!.appVersion}: $_buildVersion "),
          const SizedBox(height: 25,)
        ],
      ),
    );
  }

  Future<String> _getBuildVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

  }
}
