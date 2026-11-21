String? normalizePhone(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.length != 11) {
    return null;
  }
  if (digits[0] != '7' && digits[0] != '8') {
    return null;
  }
  return '+7${digits.substring(1)}';
}

bool isValidName(String input) {
  return input.trim().length >= 2;
}

bool isValidPassword(String input) {
  return input.length >= 4;
}
