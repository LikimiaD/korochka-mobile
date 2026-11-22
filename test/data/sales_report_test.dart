import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/bakery_store.dart';
import 'package:korochka/data/sales_report.dart';

void main() {
  late BakeryStore store;

  setUp(() {
    store = BakeryStore(now: DateTime(2026, 11, 16, 10, 0));
  });

  test('buildSalesReport: демо-данные', () {
    final report = buildSalesReport(store.orders, store.now);
    expect(report.ordersCount, 5);
    expect(report.completedCount, 3);
    expect(report.cancelledCount, 0);
    expect(report.revenue, 1235);
    expect(report.averageCheck, 412);
    expect(report.topProducts.length, 5);
    expect(report.topProducts[0].name, 'Круассан классический');
    expect(report.topProducts[0].quantity, 2);
    expect(report.topProducts[1].name, 'Эклер ванильный');
    expect(report.topProducts[1].quantity, 2);
    expect(report.topProducts[2].name, 'Багет французский');
    expect(report.topProducts[2].quantity, 1);
    expect(report.topProducts[3].name, 'Бородинский');
    expect(report.topProducts[3].quantity, 1);
    expect(report.topProducts[4].name, 'Капучино');
    expect(report.topProducts[4].quantity, 1);
  });

  test('buildSalesReport: без заказов всё по нулям', () {
    final report = buildSalesReport([], store.now);
    expect(report.ordersCount, 0);
    expect(report.revenue, 0);
    expect(report.averageCheck, 0);
    expect(report.topProducts, isEmpty);
  });

  test('buildSalesReport: заказы другого дня не учитываются', () {
    final report = buildSalesReport(store.orders, DateTime(2026, 11, 17));
    expect(report.ordersCount, 0);
    expect(report.completedCount, 0);
  });

  test('buildSalesReport: отменённый заказ уходит в отменённые', () {
    store.cancelOrder(105, byStaff: true);
    final report = buildSalesReport(store.orders, store.now);
    expect(report.ordersCount, 4);
    expect(report.cancelledCount, 1);
  });

  test('buildSalesReport: выдача заказа увеличивает выручку', () {
    store.advanceOrderStatus(104);
    final report = buildSalesReport(store.orders, store.now);
    expect(report.completedCount, 4);
    expect(report.revenue, 1675);
    expect(report.averageCheck, 419);
  });
}
