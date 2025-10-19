import 'package:intl/intl.dart';

String getLocalizedDate(
  DateTime? time,
  String locale, [
  String emptyDate = '',
]) {
  if (time == null) {
    return emptyDate;
  }

  final formatter = DateFormat(
    locale == 'en_US' ? 'MM/dd/yyyy' : 'dd/MM/yyyy',
    locale,
  );
  return formatter.format(time);
}
