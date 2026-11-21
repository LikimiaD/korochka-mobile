import 'package:material_ui/material_ui.dart';

String formatTime(DateTime time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}

String formatPickup(DateTime pickupTime, DateTime now) {
  final time = formatTime(pickupTime);
  final tomorrow = DateUtils.addDaysToDate(now, 1);
  if (DateUtils.isSameDay(pickupTime, now)) {
    return 'сегодня, $time';
  }
  if (DateUtils.isSameDay(pickupTime, tomorrow)) {
    return 'завтра, $time';
  }
  return '${formatDate(pickupTime)}, $time';
}
