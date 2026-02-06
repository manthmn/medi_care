part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, empty, error }

@freezed
class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    required CartStatus status,
    required List<CartItem> items,
    required String? error,
  }) = _CartState;

  factory CartState.initial() => const CartState(
        status: CartStatus.initial,
        items: [],
        error: null,
      );

  double get total => items.fold(
      0, (previousValue, element) => previousValue + element.totalPrice);
}
