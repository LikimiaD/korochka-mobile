import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/validation.dart';

void main() {
  test('normalizePhone', () {
    expect(normalizePhone('8 (900) 123-45-67'), '+79001234567');
    expect(normalizePhone('+7 900 123 45 67'), '+79001234567');
    expect(normalizePhone('79001234567'), '+79001234567');
  });

  test('normalizePhone: меньше 11 цифр', () {
    expect(normalizePhone(''), isNull);
    expect(normalizePhone('телефон'), isNull);
    expect(normalizePhone('9001234567'), isNull);
  });

  test('normalizePhone: больше 11 цифр', () {
    expect(normalizePhone('890012345678'), isNull);
  });

  test('normalizePhone: первая цифра не 7 и не 8', () {
    expect(normalizePhone('19001234567'), isNull);
  });

  test('isValidName', () {
    expect(isValidName(' Ян '), isTrue);
    expect(isValidName('Игорь'), isTrue);
    expect(isValidName(' А '), isFalse);
    expect(isValidName('   '), isFalse);
  });

  test('isValidPassword', () {
    expect(isValidPassword('1234'), isTrue);
    expect(isValidPassword('admin'), isTrue);
    expect(isValidPassword('123'), isFalse);
    expect(isValidPassword(''), isFalse);
  });
}
