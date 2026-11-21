enum ProductCategory {
  bread('Хлеб'),
  pastry('Выпечка'),
  cakes('Торты и пирожные'),
  drinks('Напитки');

  const ProductCategory(this.title);

  final String title;
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.weight,
    required this.description,
    this.isAvailable = true,
  });

  final int id;
  final String name;
  final ProductCategory category;
  final int price;
  final String weight;
  final String description;
  bool isAvailable;
}
