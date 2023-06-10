import 'package:intl/intl.dart';

class ConversionUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatDateTime(String date) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
  }

  static DateTime getDateTime(String date) {
    return DateFormat('dd MMM yyyy').parse(date);
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
