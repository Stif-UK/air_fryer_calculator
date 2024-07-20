import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_fryer_calculator/privacy/initialisation_helper.dart';
import 'package:air_fryer_calculator/ui/sidebar_links/privacy_policy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PrivacyLanding extends StatefulWidget {
  const PrivacyLanding({super.key});

  @override
  State<PrivacyLanding> createState() => _PrivacyLandingState();
}

class _PrivacyLandingState extends State<PrivacyLanding> {
  final _initialisationHelper = InitialisationHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacy),
      ),
      body: Column(
        children: [
          ListTile(title: Text(AppLocalizations.of(context)!.privacyPolicy),
          leading: const Icon(Icons.privacy_tip_outlined),
          onTap: (){
            Get.to(() => PrivacyPolicy());
          }),
          const Divider(thickness: 2,),
          ListTile(title: Text(AppLocalizations.of(context)!.privacySettings),
          leading: const Icon(Icons.settings),
          onTap: () async{
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final didChangePreferences =
                await _initialisationHelper.changePrivacyPreferences();
            scaffoldMessenger.showSnackBar(SnackBar(content: Text(
              didChangePreferences? 'Your Privacy choices have been updated': 'An error occurred whilst attempting to update privacy settings - please try again'
            ),));
          },),
          const Divider(thickness: 2,),
        ],
      ),
    );
  }
}
