import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateDayAndMonth(String value) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final date = inputFormat.parse(value);
    final formatter = DateFormat('MMM, d');
    return formatter.format(date);
  }

 static String formatDate(DateTime inputDate) {
    final outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }
}
