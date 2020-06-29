import 'package:intl/intl.dart';

DateTime epochToDateStr(int dt) {
  return new DateTime.fromMillisecondsSinceEpoch(dt);
}

String formatDate(dynamic dt, String format) {
  if (dt is String) {
    dt = DateTime.parse(dt);
  }
  switch (format) {
    case "yMd":
      return DateFormat.yMd().format(dt);
      break;
    case "Md":
      return DateFormat.Md().format(dt);
      break;
    case "ms":
      return DateFormat.ms().format(dt);
      break;
    case "jm":
      return DateFormat.jm().format(dt);
      break;
    case "yMMMEd":
      return DateFormat.yMMMEd().format(dt);
      break;
    default:
      // return DateFormat(format).format(dt);
      return DateFormat.yMd().add_Hm().format(dt);
      break;
  }
}

DateTime getDate(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0);
}

DateTime getTime(DateTime date) {
  return DateTime(0, 0, 0, date.hour, date.minute);
}

DateTime getRoundTime(DateTime date) {
  int hour = date.hour;
  int minute = date.minute;

  if (minute >= 0 && minute < 30) {
    minute = 30;
  } else {
    hour += 1;
    minute = 0;
  }
  return DateTime(0, 0, 0, hour, minute);
}
