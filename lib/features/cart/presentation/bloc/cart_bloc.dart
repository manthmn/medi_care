import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required CartUseCases cartUseCases})
      : _cartUseCases = cartUseCases,
        super(const CartState.initial()) {
    on<CartStarted>(_onStarted);
    on<CartItemQuantityChanged>(_onQuantityChanged);
    on<CartItemRemoved>(_onRemoved);
    on<CartCleared>(_onCleared);
  }

  final CartUseCases _cartUseCases;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _cartUseCases.getCart();
    result.fold(
      (failure) =>
          emit(state.copyWith(status: CartStatus.error, error: failure.message)),
      (items) => emit(
        state.copyWith(
          status: items.isEmpty ? CartStatus.empty : CartStatus.success,
          items: items,
        ),
      ),
    );
  }

  Future<void> _onQuantityChanged(
    CartItemQuantityChanged event,
    Emitter<CartState> emit,
  ) async {
    final result = await _cartUseCases.addOrUpdateItem(
      product: event.product,
      quantity: event.quantity,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }

  Future<void> _onRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    final result = await _cartUseCases.removeItem(event.productId);
    result.fold(
      (failure) =>
          emit(state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }

  Future<void> _onCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    final result = await _cartUseCases.clear();
    result.fold(
      (failure) =>
          emit(state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }
}

