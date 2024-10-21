import 'product_model.dart';

List<Product> generateMockProducts(int count) {
  return List<Product>.generate(count, (index) {
    return Product(
      id: index,
      name: 'Product $index',
      description: 'Description for Product $index',
      price: (index + 1) * 10.0,
    );
  });
}

final List<Product> mockProducts = generateMockProducts(1000);
