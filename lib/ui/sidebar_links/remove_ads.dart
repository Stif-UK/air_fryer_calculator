import 'package:air_fryer_calculator/api/purchase_api.dart';
import 'package:air_fryer_calculator/controller/FryerController.dart';
import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:air_fryer_calculator/ui/widgets/paywall_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          title: widget.fryerController.isAppPro.value? RemoveAdsCopy.getPageTitleSupporter() :RemoveAdsCopy.getPageTitle(),
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

                        child: widget.fryerController.isAppPro.value? RemoveAdsCopy.getButtonLabelSupporter() : RemoveAdsCopy.getButtonLabel()),
                  )

                ],
              ),
              const Divider(thickness: 2,),
              TextButton(onPressed: (){}, child: Text("Restore Purchase Status"))
            ],
          ),
        )
      ),
    );
  }

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();

    if(offerings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Options Found")));
    } else {
      final packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();

      showModalBottomSheet(
          context: context,
          builder: (context) => PaywallWidget(
        packages: packages,
        title: "Support Air Fryr",
        description: "Pay what you like! Choose any option to remove ads",
        onClickedPackage: (package) async{
          await PurchaseApi.purchasePackage(package);
          Navigator.pop(context);

        }
      )
      );


    }


  }

}
