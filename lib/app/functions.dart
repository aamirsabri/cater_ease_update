import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';




String? getStringFromDate(DateTime date, String format) {
  if (date == null) {
    return null;
  }
  var formatter = new DateFormat(format);
  return formatter.format(date);
}




bool? getBoolean(String flag) {
  if (flag.toLowerCase() == "false") {
    return false;
  } else if (flag.toLowerCase() == "true") {
    return true;
  } else {
    return null;
  }
}

String? getStringFromTIme(TimeOfDay? selectedTime) {
  if (selectedTime == null) {
    return null;
  }
  return '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}';
}

String getFormattedTimeFromDateTime(DateTime date){
  TimeOfDay time = TimeOfDay.fromDateTime(date);
  return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}

getDateFromString(String date, String format) {
  DateTime newDate = new DateFormat(format).parse(date);
  return DateTime.utc(newDate.year, newDate.month, newDate.day,newDate.hour,newDate.minute);
}

String calculateHours(DateTime start, DateTime end) {
  Duration d = end.difference(start);
  print(start.toString());
  print(end.toString());
  int hours = d.inHours.floor();
  int minutes = (d.inMinutes % 60).floor();
  return hours.toString() + ":" + minutes.toString();
}

String removeZeroFromNumber(double? number) {
  if (number == null) {
    return "";
  }
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return number.toString().replaceAll(regex, '');
}

Future<String> generateCatererId() async{
  return Uuid().v1();
}
