import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/bakery_store.dart';

void main() {
  late BakeryStore store;

  setUp(() {
    store = BakeryStore();
  });

  test('currentAccount: сначала никто не вошёл', () {
    expect(store.currentAccount, isNull);
  });

  test('registerAccount', () {
    final registered = store.registerAccount(
      name: '  Игорь ',
      phone: '8 (900) 123-45-67',
      password: '1234',
    );
    expect(registered, isTrue);
    expect(store.currentAccount!.name, 'Игорь');
    expect(store.currentAccount!.phone, '+79001234567');
    expect(store.currentAccount!.isStaff, isFalse);
  });

  test('registerAccount: телефон уже занят', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.logoutAccount();
    final registered = store.registerAccount(
      name: 'Другой',
      phone: '+7 900 123 45 67',
      password: '5678',
    );
    expect(registered, isFalse);
    expect(store.currentAccount, isNull);
    expect(
      store.registerAccount(
        name: 'Вор',
        phone: '+79990000000',
        password: '1234',
      ),
      isFalse,
    );
  });

  test('registerAccount: неверные имя, телефон или пароль', () {
    expect(
      store.registerAccount(name: 'А', phone: '89001234567', password: '1234'),
      isFalse,
    );
    expect(
      store.registerAccount(name: 'Игорь', phone: '123', password: '1234'),
      isFalse,
    );
    expect(
      store.registerAccount(
        name: 'Игорь',
        phone: '89001234567',
        password: '12',
      ),
      isFalse,
    );
    expect(store.currentAccount, isNull);
  });

  test('loginAccount: администратор из демо-данных', () {
    expect(
      store.loginAccount(phone: '+79990000000', password: 'admin'),
      isTrue,
    );
    expect(store.currentAccount!.name, 'Администратор');
    expect(store.currentAccount!.isStaff, isTrue);
  });

  test('loginAccount: телефон в любом формате', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.logoutAccount();
    expect(
      store.loginAccount(phone: '+7 900 123 45 67', password: '1234'),
      isTrue,
    );
    expect(store.currentAccount!.name, 'Игорь');
  });

  test('loginAccount: неверный пароль или телефон', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.logoutAccount();
    expect(store.loginAccount(phone: '89001234567', password: 'нет'), isFalse);
    expect(store.loginAccount(phone: '89009999999', password: '1234'), isFalse);
    expect(store.currentAccount, isNull);
  });

  test('logoutAccount', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.addCartItem(store.findProduct(5)!);
    store.logoutAccount();
    expect(store.currentAccount, isNull);
    expect(store.cart, isEmpty);
  });

  test('registerAccount и logoutAccount оповещают слушателей', () {
    var calls = 0;
    store.addListener(() => calls++);
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    expect(calls, greaterThan(0));
    calls = 0;
    store.logoutAccount();
    expect(calls, greaterThan(0));
  });
}
