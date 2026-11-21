import 'package:korochka/models/account.dart';

List<Account> seedAccounts() {
  return [
    const Account(
      name: 'Администратор',
      phone: '+79990000000',
      password: 'admin',
      isStaff: true,
    ),
  ];
}
