// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
}
