import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'DayCalc';

  @override
  String get welcome => 'DayCalc में आपका स्वागत है!';

  @override
  String counter(String count) {
    return 'काउंटर: $count';
  }

  @override
  String get changeTheme => 'थीम बदलें';

  @override
  String get chooseTheme => 'थीम चुनें';

  @override
  String get lightTheme => 'लाइट';

  @override
  String get darkTheme => 'डार्क';

  @override
  String get systemTheme => 'सिस्टम';

  @override
  String get close => 'बंद करें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appearance => 'दिखावट';

  @override
  String get theme => 'थीम';

  @override
  String get language => 'भाषा';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get sunday => 'रवि';

  @override
  String get monday => 'सोम';

  @override
  String get tuesday => 'मंगल';

  @override
  String get wednesday => 'बुध';

  @override
  String get thursday => 'गुरु';

  @override
  String get friday => 'शुक्र';

  @override
  String get saturday => 'शनि';

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get dataOperations => 'तिथि संचालन';

  @override
  String get number => 'संख्या';

  @override
  String get unit => 'इकाई';

  @override
  String get add => 'जोड़ें';

  @override
  String get subtract => 'घटाना';

  @override
  String get hours => 'घंटे';

  @override
  String get days => 'दिन';

  @override
  String get weeks => 'सप्ताह';

  @override
  String get months => 'महीने';

  @override
  String get years => 'साल';

  @override
  String get calculate => 'गणना करें';

  @override
  String get selectedDate => 'चुनी गई तारीख';

  @override
  String get calculator => 'कैलकुलेटर';

  @override
  String get history => 'इतिहास';

  @override
  String get finalDate => 'अंतिम तिथि';

  @override
  String get interval => 'अंतराल';

  @override
  String get errorLoadingHistory => 'इतिहास लोड करने में त्रुटि';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get clearHistory => 'इतिहास मिटाएं';

  @override
  String get clearHistoryConfirmation =>
      'क्या आप वाकई सभी ऑपरेशन इतिहास को मिटाना चाहते हैं? इस कार्रवाई को पूर्ववत नहीं किया जा सकता।';

  @override
  String get clearHistorySuccess => 'इतिहास सफलतापूर्वक मिटाया गया';

  @override
  String get clearHistoryError => 'इतिहास मिटाने में त्रुटि';

  @override
  String get noHistory => 'कोई इतिहास नहीं मिला';

  @override
  String get delete => 'हटाएं';

  @override
  String get noHistoryMessage => 'किए गए ऑपरेशन यहां दिखाई देंगे';

  @override
  String get deleteOperation => 'ऑपरेशन हटाएं';

  @override
  String get deleteOperationConfirmation =>
      'क्या आप वाकई ऑपरेशन हटाना चाहते हैं?';

  @override
  String get deleteOperationSuccess => 'ऑपरेशन सफलतापूर्वक हटाया गया';

  @override
  String get workingDays => 'कार्य दिवस';

  @override
  String get weekends => 'सप्ताहांत के दिन';

  @override
  String get notConsiderHolidays => 'छुट्टियों पर विचार न करें';

  @override
  String get english => 'अंग्रेजी';

  @override
  String get spanish => 'स्पेनिश';

  @override
  String get portuguese => 'पुर्तगाली';

  @override
  String get hindi => 'हिंदी';

  @override
  String get settingsWelcomeTitle => 'DayCalc चुनने के लिए धन्यवाद!';

  @override
  String get settingsSetupHint =>
      'आगे बढ़ने से पहले, कृपया निम्नलिखित विकल्पों को कॉन्फ़िगर करें:';

  @override
  String errorMessage(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get country => 'देश';

  @override
  String get selectCountry => 'देश चुनें';

  @override
  String get countryInfo =>
      'हम राष्ट्रीय और स्कूल छुट्टियों की सूची प्राप्त करने के लिए इस जानकारी का उपयोग करेंगे।';

  @override
  String get holidays => 'छुट्टियां';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get dateRange => 'तिथि सीमा';

  @override
  String get initialDate => 'प्रारंभिक तिथि';

  @override
  String get countryNotSelected => 'देश नहीं चुना गया';

  @override
  String get changeCountry => 'देश बदलें';

  @override
  String get loadingCountry => 'देश लोड हो रहा है...';

  @override
  String errorLoadingCountries(String error) {
    return 'देशों को लोड करने में त्रुटि: $error';
  }

  @override
  String errorLoadingCountry(String error) {
    return 'देश लोड करने में त्रुटि: $error';
  }

  @override
  String get holidaysApiError => 'छुट्टियां लोड करने में त्रुटि';

  @override
  String validFrom(int year) => '2020 और $year के बीच की तारीखें जोड़ें।';

  @override
  String get dateIntervalInfo =>
      'तिथियों के बीच का अंतराल 3 वर्ष से अधिक नहीं हो सकता।';

  @override
  String totalHolidaysInfo(int total) =>
      '$total राष्ट्रीय और स्कूल छुट्टियां दिखा रहा है';

  @override
  String get checkHolidaysButton => 'छुट्टियां जांचें';

  @override
  String get outOfRangeError => 'तिथियां सीमा से बाहर';

  @override
  String get invalidDateRangeError => 'प्रदान की गई तिथियां नहीं हो सकतीं:';

  @override
  String get cannotBeBefore2020 => '- 01/01/2020 से पहले हो;';

  @override
  String cannotBeAfterNow(String maxDate) => '- $maxDate के बाद हो;';

  @override
  String cannotBeInterval(String days) => '- $days दिनों से अधिक का अंतराल हो।';

  @override
  String intervalInfo(String from, String to) =>
      '$from और $to के बीच की छुट्टियां दिखा रहा है।';

  @override
  String get continueQuestion => 'क्या आप जारी रखना चाहते हैं?';

  @override
  String get confirmLabel => 'पुष्टि करें';

  @override
  String get holidayTypeSchool => 'स्कूल की छुट्टी';

  @override
  String get holidayTypeNormal => 'छुट्टी';

  @override
  String translateHolidayFragment(String fragment) {
    switch (fragment) {
      case 'Public':
        return 'सार्वजनिक';
      case 'National':
        return 'राष्ट्रीय';
      case 'FullDay':
        return 'पूरा दिन';
      case 'HalfDay':
        return 'आधा दिन';
      case 'Optional':
        return 'वैकल्पिक';
      case 'School':
        return 'स्कूल';
      default:
        return fragment;
    }
  }

  @override
  String get school => 'स्कूल';

  @override
  String get shareMessageSuccess => 'सफलतापूर्वक साझा किया गया';
}
