import 'package:korochka/models/order.dart';

List<Order> seedOrders(DateTime now) {
  final year = now.year;
  final month = now.month;
  final day = now.day;
  return [
    Order(
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
      pickupTime: DateTime(year, month, day, 9, 30),
      paymentMethod: PaymentMethod.card,
      createdAt: DateTime(year, month, day, 8, 40),
      status: OrderStatus.completed,
    ),
    Order(
      number: 102,
      items: const [
        OrderItem(
          productId: 2,
          productName: 'Бородинский',
          price: 110,
          quantity: 1,
        ),
        OrderItem(
          productId: 1,
          productName: 'Багет французский',
          price: 95,
          quantity: 1,
        ),
      ],
      customerName: 'Сергей',
      customerPhone: '+79002223344',
      pickupTime: DateTime(year, month, day, 10, 0),
      paymentMethod: PaymentMethod.cash,
      createdAt: DateTime(year, month, day, 9, 10),
      status: OrderStatus.completed,
    ),
    Order(
      number: 103,
      items: const [
        OrderItem(
          productId: 9,
          productName: 'Эклер ванильный',
          price: 150,
          quantity: 2,
        ),
        OrderItem(
          productId: 10,
          productName: 'Медовик',
          price: 220,
          quantity: 1,
        ),
        OrderItem(
          productId: 13,
          productName: 'Чай чёрный',
          price: 90,
          quantity: 1,
        ),
      ],
      customerName: 'Мария',
      customerPhone: '+79003334455',
      pickupTime: DateTime(year, month, day, 11, 0),
      paymentMethod: PaymentMethod.card,
      createdAt: DateTime(year, month, day, 9, 50),
      status: OrderStatus.completed,
    ),
    Order(
      number: 104,
      items: const [
        OrderItem(
          productId: 11,
          productName: 'Чизкейк классический',
          price: 260,
          quantity: 1,
        ),
        OrderItem(
          productId: 12,
          productName: 'Капучино',
          price: 180,
          quantity: 1,
        ),
      ],
      customerName: 'Олег',
      customerPhone: '+79004445566',
      pickupTime: DateTime(year, month, day, 12, 0),
      paymentMethod: PaymentMethod.card,
      createdAt: DateTime(year, month, day, 10, 20),
      status: OrderStatus.ready,
    ),
    Order(
      number: 105,
      items: const [
        OrderItem(
          productId: 8,
          productName: 'Пирожок с капустой',
          price: 70,
          quantity: 3,
        ),
        OrderItem(
          productId: 14,
          productName: 'Морс клюквенный',
          price: 120,
          quantity: 1,
        ),
      ],
      customerName: 'Елена',
      customerPhone: '+79005556677',
      pickupTime: DateTime(year, month, day, 13, 30),
      paymentMethod: PaymentMethod.cash,
      createdAt: DateTime(year, month, day, 10, 45),
    ),
  ];
}
