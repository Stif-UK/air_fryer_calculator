import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('da'),
    Locale('en'),
    Locale('nl')
  ];

  /// Oven Temperature label
  ///
  /// In en, this message translates to:
  /// **'Oven Temperature'**
  String get ovenTemp;

  /// No description provided for @ovenTime.
  ///
  /// In en, this message translates to:
  /// **'Oven Time'**
  String get ovenTime;

  /// No description provided for @suggestedSettings.
  ///
  /// In en, this message translates to:
  /// **'Suggested Air Fryer Settings'**
  String get suggestedSettings;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @saveToNotes.
  ///
  /// In en, this message translates to:
  /// **'Save to Notes'**
  String get saveToNotes;

  /// No description provided for @calculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get calculator;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @tempGuide.
  ///
  /// In en, this message translates to:
  /// **'Temp Guide'**
  String get tempGuide;

  /// No description provided for @tempCelsius.
  ///
  /// In en, this message translates to:
  /// **'Temperature: Celsius'**
  String get tempCelsius;

  /// No description provided for @tempFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Temperature: Fahrenheit'**
  String get tempFahrenheit;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @attributions.
  ///
  /// In en, this message translates to:
  /// **'Attributions'**
  String get attributions;

  /// No description provided for @versionHistory.
  ///
  /// In en, this message translates to:
  /// **'Version History'**
  String get versionHistory;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @supportAirFryr.
  ///
  /// In en, this message translates to:
  /// **'Support Air Fryr'**
  String get supportAirFryr;

  /// No description provided for @appReview.
  ///
  /// In en, this message translates to:
  /// **'Leave an App Review'**
  String get appReview;

  /// No description provided for @deletedNotes.
  ///
  /// In en, this message translates to:
  /// **'Deleted Notes'**
  String get deletedNotes;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @categoryFilter.
  ///
  /// In en, this message translates to:
  /// **'Category filter'**
  String get categoryFilter;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @showingAll.
  ///
  /// In en, this message translates to:
  /// **'Showing all'**
  String get showingAll;

  /// No description provided for @showingFavourites.
  ///
  /// In en, this message translates to:
  /// **'Showing favourites'**
  String get showingFavourites;

  /// No description provided for @meat.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get meat;

  /// No description provided for @seafood.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get seafood;

  /// No description provided for @poultry.
  ///
  /// In en, this message translates to:
  /// **'Poultry'**
  String get poultry;

  /// No description provided for @vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get vegetarian;

  /// No description provided for @vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get vegan;

  /// No description provided for @sides.
  ///
  /// In en, this message translates to:
  /// **'Sides'**
  String get sides;

  /// No description provided for @dessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get dessert;

  /// No description provided for @baking.
  ///
  /// In en, this message translates to:
  /// **'Baking'**
  String get baking;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get saveNote;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @beef.
  ///
  /// In en, this message translates to:
  /// **'Beef'**
  String get beef;

  /// No description provided for @rare.
  ///
  /// In en, this message translates to:
  /// **'rare'**
  String get rare;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get medium;

  /// No description provided for @wellDone.
  ///
  /// In en, this message translates to:
  /// **'well done'**
  String get wellDone;

  /// No description provided for @pork.
  ///
  /// In en, this message translates to:
  /// **'Pork'**
  String get pork;

  /// No description provided for @fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get fish;

  /// No description provided for @cake.
  ///
  /// In en, this message translates to:
  /// **'cake'**
  String get cake;

  /// No description provided for @bread.
  ///
  /// In en, this message translates to:
  /// **'bread'**
  String get bread;

  /// No description provided for @brownies.
  ///
  /// In en, this message translates to:
  /// **'brownies'**
  String get brownies;

  /// No description provided for @tempReference.
  ///
  /// In en, this message translates to:
  /// **'Temperature Reference'**
  String get tempReference;

  /// No description provided for @tempGuidance.
  ///
  /// In en, this message translates to:
  /// **'To ensure your food is safe to eat it is best to check the internal temperature with a cooking thermometer. This page provides a reference to safe internal temperatures for various food types.  \n\nNote: Guidelines for safe internal temperatures may differ in different countries. If unsure please consult your local government advice.  \n\nAir Fryr can take no responsibility for ensuring your food is safe to eat!'**
  String get tempGuidance;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @searchNotebook.
  ///
  /// In en, this message translates to:
  /// **'Search Notebook'**
  String get searchNotebook;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @dutch.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get dutch;

  /// No description provided for @danish.
  ///
  /// In en, this message translates to:
  /// **'Danish'**
  String get danish;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @translations.
  ///
  /// In en, this message translates to:
  /// **'Translations'**
  String get translations;

  /// No description provided for @emptyNotebook.
  ///
  /// In en, this message translates to:
  /// **'Your Notebook is currently empty'**
  String get emptyNotebook;

  /// No description provided for @emptyFilter.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show for the current filter'**
  String get emptyFilter;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting'**
  String get deleting;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @pieces.
  ///
  /// In en, this message translates to:
  /// **'pieces'**
  String get pieces;

  /// No description provided for @whole.
  ///
  /// In en, this message translates to:
  /// **'whole'**
  String get whole;

  /// No description provided for @showPaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Show Payment Options'**
  String get showPaymentOptions;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase Status'**
  String get restorePurchase;

  /// No description provided for @donateAgain.
  ///
  /// In en, this message translates to:
  /// **'Donate Again'**
  String get donateAgain;

  /// No description provided for @paymentQuickSummary.
  ///
  /// In en, this message translates to:
  /// **'Pay what you like! Choose any option to remove ads'**
  String get paymentQuickSummary;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get noResultsFound;

  /// No description provided for @mustBeANumber.
  ///
  /// In en, this message translates to:
  /// **'Must be a number between'**
  String get mustBeANumber;

  /// No description provided for @inputOvenTemp.
  ///
  /// In en, this message translates to:
  /// **'Input Oven Temperature'**
  String get inputOvenTemp;

  /// No description provided for @inputOvenTime.
  ///
  /// In en, this message translates to:
  /// **'Input oven time in minutes'**
  String get inputOvenTime;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @addedToNotebok.
  ///
  /// In en, this message translates to:
  /// **'added to notebook'**
  String get addedToNotebok;

  /// No description provided for @notebookUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your notebook has been updated'**
  String get notebookUpdated;

  /// No description provided for @updateNote.
  ///
  /// In en, this message translates to:
  /// **'Update Note'**
  String get updateNote;

  /// No description provided for @shareNote.
  ///
  /// In en, this message translates to:
  /// **'Share note'**
  String get shareNote;

  /// No description provided for @restoringNote.
  ///
  /// In en, this message translates to:
  /// **'Restoring Note'**
  String get restoringNote;

  /// No description provided for @deletedPageGuidance.
  ///
  /// In en, this message translates to:
  /// **'When you delete a note from the main notebook it will appear here.\n\nYou can then choose to fully delete by swiping left or restore to the notebook by swiping to the right.'**
  String get deletedPageGuidance;

  /// No description provided for @appData.
  ///
  /// In en, this message translates to:
  /// **'App Data'**
  String get appData;

  /// No description provided for @backupComplete.
  ///
  /// In en, this message translates to:
  /// **'Backup Complete'**
  String get backupComplete;

  /// No description provided for @noteBookSaved.
  ///
  /// In en, this message translates to:
  /// **'Notebook Data has been saved.'**
  String get noteBookSaved;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @backupDatabase.
  ///
  /// In en, this message translates to:
  /// **'Backup Database'**
  String get backupDatabase;

  /// No description provided for @backupGuidance.
  ///
  /// In en, this message translates to:
  /// **'Press the button below to create a copy of the app database (this can take a few seconds!). \n\nOnce created a \'share\' pop-up should appear, allowing you to choose where to send the backup file.'**
  String get backupGuidance;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreDatabase.
  ///
  /// In en, this message translates to:
  /// **'Restore Database'**
  String get restoreDatabase;

  /// No description provided for @pleaseSelectBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Please select backup file'**
  String get pleaseSelectBackupFile;

  /// No description provided for @selectBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Select Backup File'**
  String get selectBackupFile;

  /// No description provided for @fileSelected.
  ///
  /// In en, this message translates to:
  /// **'File selected'**
  String get fileSelected;

  /// No description provided for @readyToLoad.
  ///
  /// In en, this message translates to:
  /// **'Ready to load'**
  String get readyToLoad;

  /// No description provided for @restoreFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from Backup'**
  String get restoreFromBackup;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['da', 'en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
