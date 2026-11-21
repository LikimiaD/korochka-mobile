import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/models/cart_item.dart';
import 'package:korochka/models/product.dart';

void main() {
  test('CartItem.total', () {
    final croissant = Product(
      id: 5,
      name: 'Круассан классический',
      category: ProductCategory.pastry,
      price: 120,
      weight: '80 г',
      description: '',
    );
    expect(CartItem(product: croissant, quantity: 3).total, 360);
  });
}
