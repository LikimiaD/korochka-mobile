import 'package:korochka/models/order.dart';
import 'package:material_ui/material_ui.dart';

const int topProductsLimit = 5;

class TopProduct {
  const TopProduct({required this.name, required this.quantity});

  final String name;
  final int quantity;
}

class SalesReport {
  const SalesReport({
    required this.ordersCount,
    required this.completedCount,
    required this.cancelledCount,
    required this.revenue,
    required this.averageCheck,
    required this.topProducts,
  });

  final int ordersCount;
  final int completedCount;
  final int cancelledCount;
  final int revenue;
  final int averageCheck;
  final List<TopProduct> topProducts;
}

SalesReport buildSalesReport(List<Order> orders, DateTime day) {
  var ordersCount = 0;
  var completedCount = 0;
  var cancelledCount = 0;
  var revenue = 0;
  final quantities = <String, int>{};
  for (final order in orders) {
    if (!DateUtils.isSameDay(order.createdAt, day)) {
      continue;
    }
    if (order.status == OrderStatus.cancelled) {
      cancelledCount++;
    } else {
      ordersCount++;
    }
    if (order.status == OrderStatus.completed) {
      completedCount++;
      revenue += order.total;
      for (final item in order.items) {
        final quantity = quantities[item.productName] ?? 0;
        quantities[item.productName] = quantity + item.quantity;
      }
    }
  }
  var averageCheck = 0;
  if (completedCount > 0) {
    averageCheck = (revenue / completedCount).round();
  }
  return SalesReport(
    ordersCount: ordersCount,
    completedCount: completedCount,
    cancelledCount: cancelledCount,
    revenue: revenue,
    averageCheck: averageCheck,
    topProducts: _listTopProducts(quantities),
  );
}

List<TopProduct> _listTopProducts(Map<String, int> quantities) {
  final products = <TopProduct>[];
  for (final entry in quantities.entries) {
    products.add(TopProduct(name: entry.key, quantity: entry.value));
  }
  products.sort((first, second) {
    if (first.quantity != second.quantity) {
      return second.quantity.compareTo(first.quantity);
    }
    return first.name.compareTo(second.name);
  });
  return products.take(topProductsLimit).toList();
}
