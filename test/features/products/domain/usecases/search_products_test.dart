import 'package:flutter_test/flutter_test.dart';
import 'package:medi_care/features/products/domain/entities/product.dart';
import 'package:medi_care/features/products/domain/usecases/search_products.dart';

void main() {
  late SearchProducts useCase;
  late List<Product> tProducts;

  setUp(() {
    useCase = const SearchProducts();
    tProducts = [
      Product(
        id: 1,
        title: 'Fjallraven - Foldsack No. 1 Backpack',
        price: 109.95,
        description:
            'Your perfect pack for everyday use and walks in the forest.',
        image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        rating: 3.9,
        updatedAt: DateTime.now(),
      ),
      Product(
        id: 2,
        title: 'SanDisk SSD PLUS 1TB Internal SSD',
        price: 109.0,
        description:
            'Easy upgrade for faster boot up, shutdown, application load and response.',
        image: 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
        rating: 2.9,
        updatedAt: DateTime.now(),
      ),
    ];
  });

  test('should return all products when query is empty', () {
    final result = useCase(products: tProducts, query: '');
    expect(result, tProducts);
  });

  test('should return matching products by title', () {
    final result = useCase(products: tProducts, query: 'backpack');
    expect(result.length, 1);
    expect(result.first.id, 1);
  });

  test('should return matching products by description', () {
    final result = useCase(products: tProducts, query: 'faster boot');
    expect(result.length, 1);
    expect(result.first.id, 2);
  });

  test('should be case-insensitive', () {
    final result = useCase(products: tProducts, query: 'SANDISK');
    expect(result.length, 1);
    expect(result.first.id, 2);
  });

  test('should return empty list when no match is found', () {
    final result = useCase(products: tProducts, query: 'zxcv');
    expect(result, isEmpty);
  });
}
