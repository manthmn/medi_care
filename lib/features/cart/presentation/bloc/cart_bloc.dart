import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/add_or_update_item.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required GetCartUseCase getCart,
    required AddOrUpdateCartItemUseCase addOrUpdateItem,
    required RemoveCartItemUseCase removeItem,
    required ClearCartUseCase clearCart,
  })  : _getCart = getCart,
        _addOrUpdateItem = addOrUpdateItem,
        _removeItem = removeItem,
        _clearCart = clearCart,
        super(CartState.initial()) {
    on<CartStarted>(_onStarted);
    on<CartItemQuantityChanged>(_onQuantityChanged);
    on<CartItemRemoved>(_onRemoved);
    on<CartCleared>(_onCleared);
  }

  final GetCartUseCase _getCart;
  final AddOrUpdateCartItemUseCase _addOrUpdateItem;
  final RemoveCartItemUseCase _removeItem;
  final ClearCartUseCase _clearCart;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _getCart();
    result.fold(
      (failure) => emit(
          state.copyWith(status: CartStatus.error, error: failure.message)),
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
    final result = await _addOrUpdateItem(
      product: event.product,
      quantity: event.quantity,
    );
    result.fold(
      (failure) => emit(
          state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }

  Future<void> _onRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    final result = await _removeItem(event.productId);
    result.fold(
      (failure) => emit(
          state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }

  Future<void> _onCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    final result = await _clearCart();
    result.fold(
      (failure) => emit(
          state.copyWith(status: CartStatus.error, error: failure.message)),
      (_) => add(const CartStarted()),
    );
  }
}
