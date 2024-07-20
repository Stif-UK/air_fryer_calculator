import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:air_fryer_calculator/ui/widgets/paywall_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RemoveAds extends StatefulWidget {
  RemoveAds({Key? key}) : super(key: key);
  final fryerController = Get.put(FryerController());

  @override
  State<RemoveAds> createState() => _RemoveAdsState();
}

class _RemoveAdsState extends State<RemoveAds> {
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
        appBar: AppBar(
          title: widget.fryerController.isAppPro.value? RemoveAdsCopy.getPageTitleSupporter(context) :RemoveAdsCopy.getPageTitle(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: widget.fryerController.isAppPro.value? RemoveAdsCopy.getSupporterMainCopy(context) : RemoveAdsCopy.getRemoveAdsMainCopy(context)),
                  ),
                  const Divider(thickness: 2,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 40, 8, 40),
                    child: OutlinedButton(
                        onPressed:(){
                          fetchOffers();
                        },

                        child: widget.fryerController.isAppPro.value? RemoveAdsCopy.getButtonLabelSupporter(context) : RemoveAdsCopy.getButtonLabel(context)),
                  )

                ],
              ),
              const Divider(thickness: 2,),
              //If the app is not pro, then show 'restore purchase' button.
              widget.fryerController.isAppPro.value? SizedBox(height: 0,) :
              TextButton(onPressed: () async {
                if(await PurchaseApi.restorePurchases()){
                  //purchase is restored
                  widget.fryerController.updateAppPurchaseStatus();
                  Get.defaultDialog(
                    title: "Purchase Restored",
                    middleText: "You're now ad free!",
                    );
                } else {
                  //purchase restore failed
                  Get.defaultDialog(
                    title: "Restore Failed",
                    middleText: "No previous or active purchase found for user",
                  );
                }

              }, child: Text(AppLocalizations.of(context)!.restorePurchase))
            ],
          ),
        )
      ),
    );
  }

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();

    if(offerings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Options Found, try again later")));
    } else {
      final packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();

      showModalBottomSheet(
          context: context,
          builder: (context) => PaywallWidget(
        packages: packages,
        title: AppLocalizations.of(context)!.supportAirFryr,
        description: AppLocalizations.of(context)!.paymentQuickSummary,
        onClickedPackage: (package) async{
          //Pop context first - this will allow any exception dialog to show without being blocked by the bottom sheet.
          Navigator.pop(context);
          bool success = await PurchaseApi.purchasePackage(package);
                    if (success) {
            var fryerController = Get.put(FryerController());
            fryerController.updateAppPurchaseStatus();
          }


        }
      )
      );


    }


  }

}
