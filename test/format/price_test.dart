import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/format/price.dart';

void main() {
  test('formatPrice', () {
    expect(formatPrice(0), '0 ₽');
    expect(formatPrice(95), '95 ₽');
    expect(formatPrice(1235), '1 235 ₽');
    expect(formatPrice(1234567), '1 234 567 ₽');
  });
}
