import 'package:intl/intl.dart';

final _dateFormat = DateFormat.yMMMMd();

class DateFormatter {
  static String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';
}
