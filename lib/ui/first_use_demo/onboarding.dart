import 'package:air_fryer_calculator/ui/air_fryer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AirFryrOnboarding extends StatefulWidget {
  const AirFryrOnboarding({Key? key}) : super(key: key);

  @override
  State<AirFryrOnboarding> createState() => _AirFryrOnboardingState();
}

class _AirFryrOnboardingState extends State<AirFryrOnboarding> {
  final pageViewController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageViewController,
          onPageChanged: (index){
            setState(()=> isLastPage = index == 3);
          },
          children: [
            buildPage(
                colour: Theme.of(context).canvasColor,
                urlImage: 'assets/demo/page1_logo.png',
                title: "Air Fryr",
                subtitle: "Get the most from your air fryer!\nSwipe to learn what Air Fryr can do..."),
            buildPage(
                colour: Theme.of(context).canvasColor,
                urlImage: Get.isDarkMode? 'assets/demo/page1_logo.png':'assets/demo/page1_logo.png',
                title: "Calculator",
                subtitle: "Convert fan oven cooking times to air fryer equivalents"),
            buildPage(
                colour: Theme.of(context).canvasColor,
                urlImage: Get.isDarkMode? 'assets/demo/page1_logo.png': 'assets/demo/page1_logo.png',
                title: "Notebook",
                subtitle: "Save calculations and recipes. \nUse real-time search to quickly access them"),
            buildPage(
                colour: Theme.of(context).canvasColor,
                urlImage: Get.isDarkMode? 'assets/demo/page1_logo.png':'assets/demo/page1_logo.png',
                title: "Reference",
                subtitle: "Handy temperature reference to check your food is fully cooked"),
          ],
        ),
      ),
      bottomSheet:  isLastPage? Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            foregroundColor: Colors.white,
            backgroundColor: getAFColour(),
            minimumSize: const Size.fromHeight(80),
          ),
          child: const Text("Let's go!",
            style: TextStyle(fontSize: 22),),
          onPressed: () async {
            //await WristCheckPreferences.setHasSeenDemo(true);
            Get.off(()=> AirFryerHome());
          },
        ),
      ) :Container(
        padding: const EdgeInsets.all(10.0),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text("SKIP"),
              onPressed: (){
                pageViewController.jumpToPage(3);
              },),
            Center(
              child: SmoothPageIndicator(
                  controller: pageViewController,
                  effect: SlideEffect(
                    type: SlideType.slideUnder,
                    dotColor: Get.isDarkMode? Colors.white24: Colors.black26,
                    activeDotColor: getAFColour(),
                  ),
                  onDotClicked: (index) => pageViewController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                  count: 4),
            ),
            TextButton(
              child: const Text("NEXT"),
              onPressed: (){
                pageViewController.nextPage(
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeInOut);
              },),
          ],
        ),
      ),
    );
  }
  Widget buildPage({
    required Color colour,
    required String urlImage,
    required String title,
    required String subtitle
  }) => Container(
    color: colour,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(height: 32,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: getAFColour(),
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 24,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge
          ),
        )
      ],
    ),
  );

  Color getAFColour(){
    return const Color(0xffD50000);
  }
}
