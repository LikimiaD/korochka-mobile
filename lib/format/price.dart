String formatPrice(int rubles) {
  final digits = rubles.toString();
  var grouped = '';
  for (var index = 0; index < digits.length; index++) {
    final digitsLeft = digits.length - index;
    if (index > 0 && digitsLeft % 3 == 0) {
      grouped += ' ';
    }
    grouped += digits[index];
  }
  return '$grouped ₽';
}
