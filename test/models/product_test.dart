import 'package:flutter_test/flutter_test.dart';
import 'package:korochka/models/product.dart';

void main() {
  test('ProductCategory.title', () {
    expect(ProductCategory.cakes.title, 'Торты и пирожные');
  });
}
