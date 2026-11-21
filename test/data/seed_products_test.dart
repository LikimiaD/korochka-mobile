import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/data/seed_products.dart';

void main() {
  test('seedProducts', () {
    final products = seedProducts();
    expect(products.length, 14);
    expect(products[2].id, 3);
    expect(products[2].name, 'Чиабатта');
    expect(products[2].isAvailable, isFalse);
    expect(products[4].id, 5);
    expect(products[4].name, 'Круассан классический');
    expect(products[4].price, 120);
  });

  test('seedProducts: каждый вызов создаёт новые товары', () {
    final first = seedProducts();
    final second = seedProducts();
    first[0].isAvailable = false;
    expect(second[0].isAvailable, isTrue);
  });
}
