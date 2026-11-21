import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/bakery_store.dart';
import 'package:korochka/models/product.dart';

void main() {
  late BakeryStore store;

  setUp(() {
    store = BakeryStore();
  });

  test('listProducts', () {
    expect(store.listProducts(null).length, 14);
    expect(store.listProducts(ProductCategory.bread).length, 4);
    expect(store.listProducts(ProductCategory.drinks).length, 3);
  });

  test('findProduct', () {
    expect(store.findProduct(3)!.name, 'Чиабатта');
    expect(store.findProduct(3)!.isAvailable, isFalse);
    expect(store.findProduct(5)!.price, 120);
    expect(store.findProduct(99), isNull);
  });

  test('setProductAvailability', () {
    store.setProductAvailability(3, true);
    expect(store.findProduct(3)!.isAvailable, isTrue);
  });
}
