import 'package:air_fryer_calculator/copy/remove_ads_copy.dart';
import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/ui/widgets/remove_ads_bottomsheet.dart';

class RemoveAds extends StatefulWidget {
  const RemoveAds({Key? key}) : super(key: key);

  @override
  State<RemoveAds> createState() => _RemoveAdsState();
}

class _RemoveAdsState extends State<RemoveAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove Ads"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: RemoveAdsCopy.getRemoveAdsMainCopy(context)),
            ),
            const Divider(thickness: 2,),
            OutlinedButton(
                onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context){
                       return RemoveAdsSheet.getRemoveAdsSheet(context);
                        // return SizedBox(height: 500,) ;
                      });
                },
                child: RemoveAdsCopy.getButtonLabel())



          ],
        ),
      )
    );
  }
}
