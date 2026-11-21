import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/seed_accounts.dart';

void main() {
  test('seedAccounts', () {
    final accounts = seedAccounts();
    expect(accounts.length, 1);
    expect(accounts[0].name, 'Администратор');
    expect(accounts[0].phone, '+79990000000');
    expect(accounts[0].password, 'admin');
    expect(accounts[0].isStaff, isTrue);
  });
}
