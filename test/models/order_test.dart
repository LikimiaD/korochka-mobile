import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/models/order.dart';

void main() {
  test('OrderStatus.next', () {
    expect(OrderStatus.created.next, OrderStatus.inProgress);
    expect(OrderStatus.inProgress.next, OrderStatus.ready);
    expect(OrderStatus.ready.next, OrderStatus.completed);
    expect(OrderStatus.completed.next, isNull);
    expect(OrderStatus.cancelled.next, isNull);
  });

  test('OrderStatus.isFinal', () {
    expect(OrderStatus.ready.isFinal, isFalse);
    expect(OrderStatus.completed.isFinal, isTrue);
    expect(OrderStatus.cancelled.isFinal, isTrue);
  });

  test('OrderStatus.canBeCancelled: покупатель отменяет только новый', () {
    expect(OrderStatus.created.canBeCancelled(byStaff: false), isTrue);
    expect(OrderStatus.inProgress.canBeCancelled(byStaff: false), isFalse);
    expect(OrderStatus.ready.canBeCancelled(byStaff: false), isFalse);
  });

  test('OrderStatus.canBeCancelled: сотрудник отменяет до завершения', () {
    expect(OrderStatus.inProgress.canBeCancelled(byStaff: true), isTrue);
    expect(OrderStatus.ready.canBeCancelled(byStaff: true), isTrue);
    expect(OrderStatus.completed.canBeCancelled(byStaff: true), isFalse);
    expect(OrderStatus.cancelled.canBeCancelled(byStaff: true), isFalse);
  });

  test('OrderStatus: подписи', () {
    expect(OrderStatus.ready.title, 'Готов к выдаче');
    expect(OrderStatus.created.actionTitle, 'Взять в работу');
    expect(OrderStatus.completed.actionTitle, isNull);
    expect(
      OrderStatus.created.customerNote,
      'Получили ваш заказ, скоро возьмём в работу',
    );
    expect(OrderStatus.ready.customerNote, 'Всё готово, ждём вас!');
    expect(OrderStatus.completed.customerNote, 'Приятного аппетита!');
  });

  test('PaymentMethod: подписи', () {
    expect(PaymentMethod.cash.title, 'Наличными при получении');
    expect(PaymentMethod.card.shortTitle, 'Картой');
  });

  test('OrderItem.total', () {
    const item = OrderItem(
      productId: 5,
      productName: 'Круассан классический',
      price: 120,
      quantity: 2,
    );
    expect(item.total, 240);
  });

  test('Order.total', () {
    final order = Order(
      number: 101,
      items: const [
        OrderItem(
          productId: 5,
          productName: 'Круассан классический',
          price: 120,
          quantity: 2,
        ),
        OrderItem(
          productId: 12,
          productName: 'Капучино',
          price: 180,
          quantity: 1,
        ),
      ],
      customerName: 'Анна',
      customerPhone: '+79001112233',
      pickupTime: DateTime(2026, 11, 16, 9, 30),
      paymentMethod: PaymentMethod.card,
      createdAt: DateTime(2026, 11, 16, 8, 40),
    );
    expect(order.total, 420);
  });

  test('Order: статус и комментарий по умолчанию', () {
    final order = Order(
      number: 101,
      items: const [],
      customerName: 'Анна',
      customerPhone: '+79001112233',
      pickupTime: DateTime(2026, 11, 16, 9, 30),
      paymentMethod: PaymentMethod.card,
      createdAt: DateTime(2026, 11, 16, 8, 40),
    );
    expect(order.status, OrderStatus.created);
    expect(order.comment, '');
  });
}
