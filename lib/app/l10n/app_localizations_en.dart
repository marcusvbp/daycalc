// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en_US']) : super(locale);

  @override
  String get appTitle => 'DayCalc';

  @override
  String get welcome => 'Welcome to DayCalc!';

  @override
  String counter(String count) {
    return 'Counter: $count';
  }

  @override
  String get changeTheme => 'Change theme';

  @override
  String get chooseTheme => 'Choose theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get systemTheme => 'System';

  @override
  String get close => 'Close';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get sunday => 'Sun';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get selectDate => 'Select date';

  @override
  String get dataOperations => 'Date Operations';

  @override
  String get number => 'Number';

  @override
  String get unit => 'Unit';

  @override
  String get add => 'Add';

  @override
  String get subtract => 'Subtract';

  @override
  String get hours => 'Hours';

  @override
  String get days => 'Days';

  @override
  String get weeks => 'Weeks';

  @override
  String get months => 'Months';

  @override
  String get years => 'Years';

  @override
  String get calculate => 'Calculate';

  @override
  String get selectedDate => 'Selected date';

  @override
  String get calculator => 'Calculator';

  @override
  String get history => 'History';

  @override
  String get finalDate => 'Final date';

  @override
  String get interval => 'Interval';

  @override
  String get errorLoadingHistory => 'Error loading history';

  @override
  String get tryAgain => 'Try again';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get clearHistoryConfirmation =>
      'Are you sure you want to clear all operation history? This action cannot be undone.';

  @override
  String get clearHistorySuccess => 'History cleared successfully';

  @override
  String get clearHistoryError => 'Error clearing history';

  @override
  String get noHistory => 'No history found';

  @override
  String get delete => 'Delete';

  @override
  String get noHistoryMessage => 'The operations performed will appear here';

  @override
  String get deleteOperation => 'Delete Operation';

  @override
  String get deleteOperationConfirmation =>
      'Are you sure you want to delete the operation?';

  @override
  String get deleteOperationSuccess => 'Operation deleted successfully';

  @override
  String get workingDays => 'Working days';

  @override
  String get weekends => 'Weekend days';

  @override
  String get notConsiderHolidays => 'Not consider holidays';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get settingsWelcomeTitle => 'Thank you for choosing DayCalc!';

  @override
  String get settingsSetupHint =>
      'Before proceeding, please configure the following options:';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get continueLabel => 'Continue';

  @override
  String get country => 'Country';

  @override
  String get selectCountry => 'Select country';

  @override
  String get countryInfo =>
      'We will use this information to get the list of national and school holidays.';
}
