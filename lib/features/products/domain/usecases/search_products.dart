import '../entities/product.dart';

class SearchProducts {
  const SearchProducts();

  List<Product> call({
    required List<Product> products,
    required String query,
  }) {
    if (query.trim().isEmpty) return products;
    final lower = query.toLowerCase();
    return products
        .where(
          (p) =>
              p.title.toLowerCase().contains(lower) ||
              p.description.toLowerCase().contains(lower),
        )
        .toList();
  }
}

