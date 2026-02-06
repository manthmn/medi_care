part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  empty,
  error,
  firstLaunchOffline,
}

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    required this.allProducts,
    required this.visibleProducts,
    required this.searchQuery,
    required this.error,
  });

  const ProductState.initial()
      : status = ProductStatus.initial,
        allProducts = const [],
        visibleProducts = const [],
        searchQuery = '',
        error = null;

  final ProductStatus status;
  final List<Product> allProducts;
  final List<Product> visibleProducts;
  final String searchQuery;
  final String? error;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? allProducts,
    List<Product>? visibleProducts,
    String? searchQuery,
    String? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      visibleProducts: visibleProducts ?? this.visibleProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [status, allProducts, visibleProducts, searchQuery, error];
}

