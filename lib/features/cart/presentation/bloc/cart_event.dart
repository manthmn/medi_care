part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {
  const CartStarted();
}

class CartItemQuantityChanged extends CartEvent {
  const CartItemQuantityChanged({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  @override
  List<Object?> get props => [product, quantity];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.productId);

  final int productId;

  @override
  List<Object?> get props => [productId];
}

class CartCleared extends CartEvent {
  const CartCleared();
}

