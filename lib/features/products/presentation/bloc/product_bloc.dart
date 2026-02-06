import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required GetProducts getProducts,
    required SearchProducts searchProducts,
  })  : _getProducts = getProducts,
        _searchProducts = searchProducts,
        super(const ProductState.initial()) {
    on<_LoadRequested>(_onLoadRequested);
    on<_SearchQueryChanged>(_onSearchQueryChanged,
        transformer: _debounce(const Duration(milliseconds: 300)));
    on<_RefreshRequested>(_onLoadRequested);
  }

  final GetProducts _getProducts;
  final SearchProducts _searchProducts;

  Future<void> _onLoadRequested(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, error: null));
    final result = await _getProducts();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: failure is CacheFailure
              ? ProductStatus.firstLaunchOffline
              : ProductStatus.error,
          error: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status:
              products.isEmpty ? ProductStatus.empty : ProductStatus.success,
          allProducts: products,
          visibleProducts: products,
        ),
      ),
    );
  }

  FutureOr<void> _onSearchQueryChanged(
    _SearchQueryChanged event,
    Emitter<ProductState> emit,
  ) {
    final filtered = _searchProducts(
      products: state.allProducts,
      query: event.query,
    );
    emit(
      state.copyWith(
        searchQuery: event.query,
        visibleProducts: filtered,
      ),
    );
  }

  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).asyncExpand(mapper);
  }
}

