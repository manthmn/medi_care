part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, empty, error }

class CartState extends Equatable {
  const CartState({
    required this.status,
    required this.items,
    required this.error,
  });

  const CartState.initial()
      : status = CartStatus.initial,
        items = const [],
        error = null;

  final CartStatus status;
  final List<CartItem> items;
  final String? error;

  double get total =>
      items.fold(0, (previousValue, element) => previousValue + element.totalPrice);

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}

