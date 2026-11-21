const int openingHour = 8;
const int closingHour = 20;
const int slotStepMinutes = 30;
const int preparationMinutes = 30;

List<DateTime> listPickupSlots(DateTime now) {
  final earliest = now.add(const Duration(minutes: preparationMinutes));
  final todaySlots = _listDaySlots(now, earliest);
  if (todaySlots.isNotEmpty) {
    return todaySlots;
  }
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  return _listDaySlots(tomorrow, earliest);
}

List<DateTime> _listDaySlots(DateTime day, DateTime earliest) {
  final closing = DateTime(day.year, day.month, day.day, closingHour);
  final slots = <DateTime>[];
  var slot = DateTime(day.year, day.month, day.day, openingHour);
  while (!slot.isAfter(closing)) {
    if (!slot.isBefore(earliest)) {
      slots.add(slot);
    }
    slot = slot.add(const Duration(minutes: slotStepMinutes));
  }
  return slots;
}
