import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/bakery_store.dart';
import 'package:korochka/models/order.dart';

void main() {
  late BakeryStore store;

  setUp(() {
    store = BakeryStore(now: DateTime(2026, 11, 16, 10, 0));
  });

  test('now', () {
    expect(store.now, DateTime(2026, 11, 16, 10, 0));
  });

  test('orders: демо-заказы по убыванию номера', () {
    expect(store.orders.length, 5);
    expect(store.orders.first.number, 105);
  });

  test('findOrder', () {
    expect(store.findOrder(104)!.status, OrderStatus.ready);
    expect(store.findOrder(104)!.total, 440);
    expect(store.findOrder(103)!.total, 610);
    expect(store.findOrder(999), isNull);
  });

  test('myOrders: никто не вошёл', () {
    expect(store.myOrders, isEmpty);
  });

  test('myOrders: только заказы вошедшего покупателя', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.addCartItem(store.findProduct(5)!, quantity: 2);
    store.addCartItem(store.findProduct(12)!);
    store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 14, 30),
      paymentMethod: PaymentMethod.card,
      comment: 'Без пакета',
    );
    store.logoutAccount();
    store.registerAccount(name: 'Анна', phone: '89007654321', password: '1234');
    expect(store.myOrders, isEmpty);
    store.logoutAccount();
    store.loginAccount(phone: '89001234567', password: '1234');
    expect(store.myOrders.single.number, 106);
  });

  test('placeOrder', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.addCartItem(store.findProduct(5)!, quantity: 2);
    store.addCartItem(store.findProduct(12)!);
    final order = store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 14, 30),
      paymentMethod: PaymentMethod.card,
      comment: ' Без пакета ',
    )!;
    expect(order.number, 106);
    expect(order.total, 420);
    expect(order.items.length, 2);
    expect(order.status, OrderStatus.created);
    expect(order.customerName, 'Игорь');
    expect(order.customerPhone, '+79001234567');
    expect(order.comment, 'Без пакета');
    expect(order.createdAt, DateTime(2026, 11, 16, 10, 0));
    expect(store.cart, isEmpty);
    expect(store.orders.first.number, 106);
    expect(store.myOrders.single.number, 106);
  });

  test('placeOrder: никто не вошёл', () {
    store.addCartItem(store.findProduct(5)!);
    final order = store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 15, 0),
      paymentMethod: PaymentMethod.cash,
    );
    expect(order, isNull);
    expect(store.orders.length, 5);
    expect(store.cart.length, 1);
  });

  test('placeOrder: пустая корзина', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.addCartItem(store.findProduct(5)!, quantity: 2);
    store.addCartItem(store.findProduct(12)!);
    store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 14, 30),
      paymentMethod: PaymentMethod.card,
      comment: 'Без пакета',
    );
    final second = store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 15, 0),
      paymentMethod: PaymentMethod.cash,
    );
    expect(second, isNull);
    expect(store.orders.length, 6);
  });

  test('placeOrder: недоступный товар в корзине', () {
    store.registerAccount(
      name: 'Игорь',
      phone: '89001234567',
      password: '1234',
    );
    store.addCartItem(store.findProduct(5)!);
    store.setProductAvailability(5, false);
    final order = store.placeOrder(
      pickupTime: DateTime(2026, 11, 16, 15, 0),
      paymentMethod: PaymentMethod.cash,
    );
    expect(order, isNull);
    expect(store.cart.length, 1);
  });

  test('advanceOrderStatus', () {
    expect(store.advanceOrderStatus(105), isTrue);
    expect(store.findOrder(105)!.status, OrderStatus.inProgress);
    expect(store.advanceOrderStatus(105), isTrue);
    expect(store.advanceOrderStatus(105), isTrue);
    expect(store.findOrder(105)!.status, OrderStatus.completed);
    expect(store.advanceOrderStatus(105), isFalse);
    expect(store.advanceOrderStatus(999), isFalse);
  });

  test('cancelOrder: покупатель отменяет только новый', () {
    expect(store.cancelOrder(104, byStaff: false), isFalse);
    expect(store.cancelOrder(105, byStaff: false), isTrue);
    expect(store.findOrder(105)!.status, OrderStatus.cancelled);
  });

  test('cancelOrder: сотрудник отменяет до завершения', () {
    expect(store.cancelOrder(104, byStaff: true), isTrue);
    expect(store.cancelOrder(101, byStaff: true), isFalse);
  });

  test('cancelOrder: заказа нет', () {
    expect(store.cancelOrder(999, byStaff: true), isFalse);
  });
}
