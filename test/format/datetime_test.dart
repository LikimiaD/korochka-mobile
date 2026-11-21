import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/format/datetime.dart';

void main() {
  test('formatTime', () {
    expect(formatTime(DateTime(2026, 3, 5, 9, 5)), '09:05');
  });

  test('formatDate', () {
    expect(formatDate(DateTime(2026, 3, 5, 9, 5)), '05.03.2026');
  });

  test('formatPickup', () {
    final now = DateTime(2026, 11, 16, 10, 0);
    expect(formatPickup(DateTime(2026, 11, 16, 14, 30), now), 'сегодня, 14:30');
    expect(formatPickup(DateTime(2026, 11, 17, 8, 0), now), 'завтра, 08:00');
    expect(
      formatPickup(DateTime(2026, 11, 20, 8, 0), now),
      '20.11.2026, 08:00',
    );
  });

  test('formatPickup: завтра через границу месяца', () {
    final now = DateTime(2026, 11, 30, 19, 45);
    expect(formatPickup(DateTime(2026, 12, 1, 8, 0), now), 'завтра, 08:00');
  });
}
