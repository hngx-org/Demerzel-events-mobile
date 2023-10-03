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

String timeLeft(String startDate, String startTime) {
  //final formatter =DateFormat('HH:mm');
  final DateTime date;

  if (RegExp(r'^[0-9]{2}:[0-9]$').hasMatch(startTime)) {
    startTime = '${startTime.substring(0, 3)}0${startTime.substring(3)}';
    date = DateTime.parse("${startDate}T$startTime");
  } else if (RegExp('^[0-9]:[0-9]{2}').hasMatch(startTime)) {
    startTime = '0${startTime.substring(0)}';
    date = DateTime.parse("${startDate}T$startTime");
  } else {
    date = DateTime.parse("${startDate}T$startTime");
  }

  final date2 = DateTime.now();
  final difference = date.difference(date2);

  if ((difference.inDays / 7).floor() >= 1) {
    return '1 week Left';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days Left';
  } else if (difference.inDays >= 1) {
    return '1 day Left';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours Left';
  } else if (difference.inHours >= 1) {
    return '1 hour Left';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes Left';
  } else if (difference.inMinutes >= 1) {
    return '1 minute Left';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds Left';
  } else {
    return 'Expired';
  }
}

}
