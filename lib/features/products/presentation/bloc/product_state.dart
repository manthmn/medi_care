part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  empty,
  error,
  firstLaunchOffline,
}

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    required ProductStatus status,
    required List<Product> allProducts,
    required List<Product> visibleProducts,
    required String searchQuery,
    required String? error,
  }) = _ProductState;

  factory ProductState.initial() => const ProductState(
        status: ProductStatus.initial,
        allProducts: [],
        visibleProducts: [],
        searchQuery: '',
        error: null,
      );
}
