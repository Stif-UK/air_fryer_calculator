import 'package:in_app_review/in_app_review.dart';
import 'package:air_fryer_calculator/model/fryer_preferences.dart';

class ReviewHelper{

  static shouldPromptReview() async {
    //Summary of logic: Opened more than 10 times, first used over a week ago, not prompted within last 60 days

    int openCount = FryerPreferences.getOpenCount() ?? 0;
    //first ensure the app has been opened at least 10 times
    if(openCount > 10) {
      print("Open Count: $openCount is greater than 10");
      DateTime? firstUsed = FryerPreferences.getFirstUseDate();
      if (firstUsed != null) {
        DateTime timeNow = DateTime.now();
        Duration timeDiff1 = timeNow.difference(firstUsed);
        //next confirm that it is at least one week since the app was first used
        print("Difference between $firstUsed and $timeNow is ${timeDiff1.inDays}: Make sure this is not negative!");
        if(timeDiff1.inDays > 6 ){
          print("$timeDiff1 is greater than 7 days");
          //finally, check that the user has not been prompted in the last 60 days
          DateTime? lastReviewPrompted = FryerPreferences.getLastReviewPromptDate();

          //if there hasn't been a review yet then prompt for one
          if(lastReviewPrompted == null){
              ReviewHelper.promptReview();
          } else {
            //else check it's been at least 60 days
            Duration timeDiff2 = timeNow.difference(lastReviewPrompted);
            if(timeDiff2.inDays > 59){
              ReviewHelper.promptReview();
            }
          }



        }

      }



    }
  }

  static promptReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
    FryerPreferences.setLastReviewPromptDate(DateTime.now());
    }
  }

}