/// Formats a datetime without hours, minutes and seconds and return it as a string
String getDateTimeInDbFormat(DateTime dateTime) {
  return dateTime.toIso8601String().substring(0, 10);
}
