import 'package:daycalc/app/modules/open_holidays/models/country.dart';
import 'package:daycalc/app/modules/open_holidays/models/localized_text.dart';
import 'package:flutter/material.dart';

extension CountryExtension on Country {
  String displayName(BuildContext context) {
    final preferred = Localizations.localeOf(
      context,
    ).languageCode.toLowerCase();
    LocalizedText? match;
    for (final n in name) {
      if (n.language.toLowerCase().startsWith(preferred)) {
        match = n;
        break;
      }
    }
    return match?.text ?? (name.isNotEmpty ? name.first.text : isoCode);
  }
}
