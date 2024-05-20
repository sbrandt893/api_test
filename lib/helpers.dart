// format datetime without hours and minutes and seconds

DateTime dateTimeDBformat(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
