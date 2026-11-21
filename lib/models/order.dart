enum OrderStatus {
  created(
    'Новый',
    'Взять в работу',
    'Получили ваш заказ, скоро возьмём в работу',
  ),
  inProgress('Готовится', 'Готов к выдаче', 'Собираем ваш заказ'),
  ready('Готов к выдаче', 'Выдать заказ', 'Всё готово, ждём вас!'),
  completed('Выдан', null, 'Приятного аппетита!'),
  cancelled('Отменён', null, 'Заказ отменён');

  const OrderStatus(this.title, this.actionTitle, this.customerNote);

  final String title;
  final String? actionTitle;
  final String customerNote;

  OrderStatus? get next {
    switch (this) {
      case OrderStatus.created:
        return OrderStatus.inProgress;
      case OrderStatus.inProgress:
        return OrderStatus.ready;
      case OrderStatus.ready:
        return OrderStatus.completed;
      case OrderStatus.completed:
      case OrderStatus.cancelled:
        return null;
    }
  }

  bool get isFinal {
    return this == OrderStatus.completed || this == OrderStatus.cancelled;
  }

  bool canBeCancelled({required bool byStaff}) {
    if (byStaff) {
      return !isFinal;
    }
    return this == OrderStatus.created;
  }
}

enum PaymentMethod {
  cash('Наличными при получении', 'Наличными'),
  card('Картой при получении', 'Картой');

  const PaymentMethod(this.title, this.shortTitle);

  final String title;
  final String shortTitle;
}

class OrderItem {
  const OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  final int productId;
  final String productName;
  final int price;
  final int quantity;

  int get total => price * quantity;
}

class Order {
  Order({
    required this.number,
    required this.items,
    required this.customerName,
    required this.customerPhone,
    required this.pickupTime,
    required this.paymentMethod,
    required this.createdAt,
    this.comment = '',
    this.status = OrderStatus.created,
  });

  final int number;
  final List<OrderItem> items;
  final String customerName;
  final String customerPhone;
  final DateTime pickupTime;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;
  final String comment;
  OrderStatus status;

  int get total {
    var sum = 0;
    for (final item in items) {
      sum += item.total;
    }
    return sum;
  }
}
