part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  const factory ProductEvent.loadRequested() = _LoadRequested;

  const factory ProductEvent.refreshRequested() = _RefreshRequested;

  const factory ProductEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;

  @override
  List<Object?> get props => [];
}

class _LoadRequested extends ProductEvent {
  const _LoadRequested();
}

class _RefreshRequested extends ProductEvent {
  const _RefreshRequested();
}

class _SearchQueryChanged extends ProductEvent {
  const _SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

