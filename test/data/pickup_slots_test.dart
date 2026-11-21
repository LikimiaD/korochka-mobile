import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/pickup_slots.dart';

void main() {
  test('listPickupSlots: первый слот через 30 минут с округлением вверх', () {
    final slots = listPickupSlots(DateTime(2026, 11, 16, 10, 10));
    expect(slots.first, DateTime(2026, 11, 16, 11, 0));
    expect(slots.last, DateTime(2026, 11, 16, 20, 0));
    expect(slots.length, 19);
  });

  test('listPickupSlots: ровно на получасе округление не нужно', () {
    final slots = listPickupSlots(DateTime(2026, 11, 16, 10, 0));
    expect(slots.first, DateTime(2026, 11, 16, 10, 30));
  });

  test('listPickupSlots: последний слот дня', () {
    final slots = listPickupSlots(DateTime(2026, 11, 16, 19, 20));
    expect(slots, [DateTime(2026, 11, 16, 20, 0)]);
  });

  test('listPickupSlots: поздно вечером слоты на завтра', () {
    final slots = listPickupSlots(DateTime(2026, 11, 16, 19, 31));
    expect(slots.first, DateTime(2026, 11, 17, 8, 0));
    expect(slots.last, DateTime(2026, 11, 17, 20, 0));
    expect(slots.length, 25);
  });

  test('listPickupSlots: до открытия слоты с 08:00', () {
    final slots = listPickupSlots(DateTime(2026, 11, 16, 6, 0));
    expect(slots.first, DateTime(2026, 11, 16, 8, 0));
    expect(slots.length, 25);
  });

  test('listPickupSlots: завтра через границу месяца', () {
    final slots = listPickupSlots(DateTime(2026, 11, 30, 21, 0));
    expect(slots.first, DateTime(2026, 12, 1, 8, 0));
  });
}
