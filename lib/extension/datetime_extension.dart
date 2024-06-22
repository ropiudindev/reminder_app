extension DateTimeExtension on DateTime {
  DateTime at(DateTime time) {
    return copyWith(hour: time.hour, minute: time.minute, second: time.second);
  }
}