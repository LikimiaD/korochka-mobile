import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/bakery_store.dart';

void main() {
  late BakeryStore store;

  setUp(() {
    store = BakeryStore();
  });

  test('addCartItem', () {
    final croissant = store.findProduct(5)!;
    final cappuccino = store.findProduct(12)!;
    expect(store.addCartItem(croissant), isTrue);
    store.addCartItem(croissant, quantity: 2);
    store.addCartItem(cappuccino);
    expect(store.cart.length, 2);
    expect(store.cart[0].quantity, 3);
    expect(store.cart[1].quantity, 1);
  });

  test('addCartItem: недоступный товар', () {
    expect(store.addCartItem(store.findProduct(3)!), isFalse);
    expect(store.cart, isEmpty);
  });

  test('addCartItem: не больше 20 штук', () {
    store.addCartItem(store.findProduct(5)!, quantity: 25);
    expect(store.getCartQuantity(5), 20);
  });

  test('getCartQuantity', () {
    store.addCartItem(store.findProduct(5)!, quantity: 3);
    store.addCartItem(store.findProduct(12)!);
    expect(store.getCartQuantity(5), 3);
    expect(store.getCartQuantity(1), 0);
  });

  test('cartCount', () {
    store.addCartItem(store.findProduct(5)!, quantity: 3);
    store.addCartItem(store.findProduct(12)!);
    expect(store.cartCount, 4);
  });

  test('cartTotal', () {
    store.addCartItem(store.findProduct(5)!, quantity: 3);
    store.addCartItem(store.findProduct(12)!);
    expect(store.cartTotal, 540);
  });

  test('changeCartQuantity', () {
    store.addCartItem(store.findProduct(5)!, quantity: 25);
    expect(store.getCartQuantity(5), 20);
    store.changeCartQuantity(5, 1);
    expect(store.getCartQuantity(5), 20);
    store.changeCartQuantity(5, -19);
    expect(store.getCartQuantity(5), 1);
    store.changeCartQuantity(5, -1);
    expect(store.cart, isEmpty);
  });

  test('removeCartItem', () {
    store.addCartItem(store.findProduct(5)!);
    store.removeCartItem(5);
    expect(store.cart, isEmpty);
  });

  test('cartHasUnavailable', () {
    store.addCartItem(store.findProduct(5)!);
    expect(store.cartHasUnavailable, isFalse);
    store.setProductAvailability(5, false);
    expect(store.cartHasUnavailable, isTrue);
    store.removeCartItem(5);
    expect(store.cartHasUnavailable, isFalse);
  });

  test('addCartItem и setProductAvailability оповещают слушателей', () {
    var calls = 0;
    store.addListener(() => calls++);
    store.addCartItem(store.findProduct(5)!);
    store.setProductAvailability(1, false);
    expect(calls, 2);
  });
}
