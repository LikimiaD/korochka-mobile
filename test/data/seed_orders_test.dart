import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/seed_orders.dart';
import 'package:korochka/models/order.dart';

void main() {
  test('seedOrders', () {
    final orders = seedOrders(DateTime(2026, 11, 16, 10, 0));
    expect(orders.length, 5);

    expect(orders[0].number, 101);
    expect(orders[0].total, 420);
    expect(orders[0].status, OrderStatus.completed);

    expect(orders[1].number, 102);
    expect(orders[1].total, 205);
    expect(orders[1].status, OrderStatus.completed);

    expect(orders[2].number, 103);
    expect(orders[2].total, 610);
    expect(orders[2].status, OrderStatus.completed);

    expect(orders[3].number, 104);
    expect(orders[3].total, 440);
    expect(orders[3].status, OrderStatus.ready);

    expect(orders[4].number, 105);
    expect(orders[4].total, 330);
    expect(orders[4].status, OrderStatus.created);
  });

  test('seedOrders: дата берётся из переданного времени', () {
    final orders = seedOrders(DateTime(2026, 11, 16, 10, 0));
    expect(orders[0].createdAt, DateTime(2026, 11, 16, 8, 40));
    expect(orders[0].pickupTime, DateTime(2026, 11, 16, 9, 30));
  });
}
